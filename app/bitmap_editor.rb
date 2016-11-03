class BitmapEditor

  def run
    @running = true
    puts 'type ? for help'
    while @running
      print '> '
      input = gets.chomp
      case input
        when '?'
          show_help
        when /\s*I\s+\d+\s+\d+\s*\z/
          init_new_image(input)
        when /\s*C\s*\z/
          clean_image
        when /\s*L\s+\d+\s+\d+\s+[A-Z]\s*\z/
          draw_pixel(input)
        when /\s*V\s+\d+\s+\d+\s+\d+\s+[A-Z]\s*\z/
          draw_vertical_line(input)
        when /\s*S\s*\z/
          show
        when /\s*X\s*\z/
          exit_console
        else
          puts "unrecognised command :( please enter '?' for help"
      end
    end
  end

  private
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
          puts "X should be between 1 and #{@width}, Y should be between 1 and #{@height} or enter '?' for help"
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
          puts "X should be between 1 and #{@width}, Y1/Y2 should be between 1 and #{@height} or enter '?' for help"
        end
      else
        msg_empty_image
      end
    end

    def show
      @image.each{|row| puts row} if @image
    end

    def msg_empty_image
      puts "you must create image, enter '?' for help"
    end

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
