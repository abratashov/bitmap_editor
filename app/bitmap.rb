class Bitmap
  def init_new_image(input)
    params = input.split(' ')
    @width, @height = params[1].to_i, params[2].to_i
    @image = []
    clean_image
  end

  def clean_image
    if @image
      @image = []
      @height.times.each {|time| @image << 'O'*@width}
    else
      msg_empty_image
    end
  end

  def draw_pixel(input)
    if @image
      params = input.split(' ')
      x, y, colour = params[1].to_i, params[2].to_i, params[3]
      if x.between?(1, @width) && y.between?(1, @height)
        @image[y-1][x-1] = colour
      else
        message("X should be between 1 and #{@width}, Y should be between 1 and #{@height} or enter '?' for help")
      end
    else
      msg_empty_image
    end
  end

  def draw_vertical_line(input)
    if @image
      params = input.split(' ')
      x, y1, y2, colour = params[1].to_i, params[2].to_i, params[3].to_i, params[4]
      if x.between?(1, @width) &&
         y1.between?(1, @height) && y2.between?(1, @height) &&
         y1 <= y2

        (y1..y2).each{|y| @image[y-1][x-1] = colour}
      else
        message("X should be between 1 and #{@width}, Y1/Y2 should be between 1 and #{@height} or enter '?' for help")
      end
    else
      msg_empty_image
    end
  end

  def draw_horizontal_line(input)
    if @image
      params = input.split(' ')
      x1, x2, y, colour = params[1].to_i, params[2].to_i, params[3].to_i, params[4]
      if x1.between?(1, @width) && x2.between?(1, @width) &&
         x1 <= x2 &&
         y.between?(1, @height)

        (x1..x2).each{|x| @image[y-1][x-1] = colour}
      else
        message("X1/X2 should be between 1 and #{@width}, Y should be between 1 and #{@height} or enter '?' for help")
      end
    else
      msg_empty_image
    end
  end

  def image
    @image
  end

  private

  def msg_empty_image
    message("you must create image, enter '?' for help")
  end

  def message(msg)
    { description: msg }
  end
end
