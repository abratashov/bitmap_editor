load 'app/bitmap.rb'

class BitmapEditor

  def run
    @running = true
    bitmap = Bitmap.new
    puts 'type ? for help'
    while @running
      print '> '
      input = gets.chomp
      @message = nil
      case input
        when '?'
          show_help
        when /\s*I\s+\d+\s+\d+\s*\z/
          @message = bitmap.init_new_image(input)
        when /\s*C\s*\z/
          @message = bitmap.clean_image
        when /\s*L\s+\d+\s+\d+\s+[A-Z]\s*\z/
          @message = bitmap.draw_pixel(input)
        when /\s*V\s+\d+\s+\d+\s+\d+\s+[A-Z]\s*\z/
          @message = bitmap.draw_vertical_line(input)
        when /\s*H\s+\d+\s+\d+\s+\d+\s+[A-Z]\s*\z/
          @message = bitmap.draw_horizontal_line(input)
        when /\s*S\s*\z/
          @message = bitmap.show
        when /\s*X\s*\z/
          exit_console
        else
          puts "unrecognised command :( please enter '?' for help"
      end
      puts @message[:description] if @message.class == Hash && @message[:description]
    end
  end

  private
    def exit_console
      puts 'goodbye!'
      @running = false
    end

    def show_help
      puts "? - Help
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
S - Show the contents of the current image
X - Terminate the session"
    end
end
