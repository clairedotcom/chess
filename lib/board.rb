class Board
  def initialize
    @display = Array.new(8) { Array.new(8, ' ') }
  end

  def create_display(white_set, black_set)
    @display.each_with_index do |row, x|
      row.each_with_index do |_col, y|
        @display[x][y] = (x + y).even? ? colorize('white') : colorize('black')
      end
    end
    place_white_pieces(white_set)
    place_black_pieces(black_set)
    print_board
  end

  def place_white_pieces(set)
    set.each do |piece|
      x = piece.position[0]
      y = piece.position[1]
      name = piece.class.name.downcase
      @display[x][y] = (x + y).even? ? white_bg(white_pieces(name)) : black_bg(white_pieces(name))
    end
  end

  def place_black_pieces(set)
    set.each do |piece|
      x = piece.position[0]
      y = piece.position[1]
      name = piece.class.name.downcase
      @display[x][y] = (x + y).even? ? white_bg(black_pieces(name)) : black_bg(black_pieces(name))
    end
  end

  def print_board
    @display.unshift(['1 ', '2 ', '3 ', '4 ', '5 ', '6 ', '7 ', '8 '])
    @display.push([' 1 ', '2 ', '3 ', '4 ', '5 ', '6 ', '7 ', '8 '])
    letters = [' ', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']

    @display.each_with_index do |row, i|
      puts "#{letters[i]} #{row.join('')} #{letters[i]}"
    end
    @display.pop(2)
  end

  def colorize(square)
    {
      'white' => "\e[46m  \e[0m",
      'black' => "\e[44m  \e[0m"
    }[square]
  end

  def black_bg(piece)
    "\e[44m#{piece}\e[0m"
  end

  def white_bg(piece)
    "\e[46m#{piece}\e[0m"
  end

  def white_pieces(piece)
    {
      'king' => "\e[37m\u265A \e[0m",
      'queen' => "\e[37m\u265B \e[0m",
      'rook' => "\e[37m\u265C \e[0m",
      'bishop' => "\e[37m\u265D \e[0m",
      'knight' => "\e[37m\u265E \e[0m",
      'pawn' => "\e[37m\u265F \e[0m"
    }[piece]
  end

  def black_pieces(piece)
    {
      'king' => "\e[30m\u265A \e[0m",
      'queen' => "\e[30m\u265B \e[0m",
      'rook' => "\e[30m\u265C \e[0m",
      'bishop' => "\e[30m\u265D \e[0m",
      'knight' => "\e[30m\u265E \e[0m",
      'pawn' => "\e[30m\u265F \e[0m"
    }[piece]
  end
end
