class Display
  def initialize(piece_positions)
    @piece_positions = piece_positions
    @display = Array.new(8) { Array.new(8, ' ') }
  end

  def print_display
    colorize_empty_board
    place_pieces
    print_board
  end

  private

  def place_pieces
    @piece_positions.each do |piece|
      x = piece.position[0]
      y = piece.position[1]
      @display[y][x] = (x + y).even? ? black_background(piece.icon) : white_background(piece.icon)
    end
  end

  def print_board
    letters = ['  a ', 'b', ' c', ' d', ' e', ' f', ' g', ' h']
    numbers = [' ', '8 ', '7 ', '6 ', '5 ', '4 ', '3 ', '2 ', '1 ']

    @display.unshift(letters)
    @display.push([' a ', 'b ', 'c ', 'd ', 'e ', 'f ', 'g ', 'h'])

    @display.reverse.each_with_index do |row, i|
      puts "#{numbers[i]} #{row.join('')} #{numbers[i]}"
    end

    @display.pop(2)
  end

  def colorize_empty_board
    @display.each_with_index do |row, x|
      row.each_with_index do |_col, y|
        @display[x][y] = (x + y).even? ? "\e[44m  \e[0m" : "\e[46m  \e[0m"
      end
    end
  end

  def black_background(piece)
    "\e[44m#{piece}\e[0m"
  end

  def white_background(piece)
    "\e[46m#{piece}\e[0m"
  end
end
