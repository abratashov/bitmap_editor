require 'spec_helper'
load 'app/bitmap.rb'

describe Bitmap do
  let(:bitmap) {Bitmap.new}

  before(:each) do
    bitmap.init_new_image('I 3 3')
  end

  context 'Valid drawing' do
    it 'Create image' do
      expect(bitmap.image[0]).to eq 'OOO'
    end

    it 'Draw pixel' do
      bitmap.draw_pixel('L 1 1 A')
      expect(bitmap.image[0][0]).to eq 'A'
    end

    it 'Draw vertical line' do
      bitmap.draw_vertical_line('V 1 1 2 A')
      expect(bitmap.image[0][0]).to eq 'A'
      expect(bitmap.image[1][0]).to eq 'A'
    end

    it 'Draw horizontal line' do
      res = bitmap.draw_horizontal_line('H 1 2 1 A')
      expect(bitmap.image[0][0]).to eq 'A'
      expect(bitmap.image[0][1]).to eq 'A'
    end

    it 'Clean image' do
      bitmap.draw_pixel('L 1 1 A')
      bitmap.clean_image
      expect(bitmap.image[0][0]).to eq 'O'
    end
  end

  context 'Invalid drawing' do
    it { expect(bitmap.init_new_image('I 100000 3')[:description]).to include("width or height can't be more than") }
    it { expect(bitmap.draw_pixel('L 16 1 A')[:description]).to include("should be between") }
    it { expect(bitmap.draw_vertical_line('V 16 1 2 A')[:description]).to include("should be between") }
    it { expect(bitmap.draw_horizontal_line('V 1 16 2 A')[:description]).to include("should be between") }
  end
end
