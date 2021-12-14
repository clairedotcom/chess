module DisplayGenerator
  def place_white_pieces(set)
    set.each do |piece|
      x = piece.position[0]
      y = piece.position[1]
      name = piece.class.name.downcase
      @display[y][x] = (x + y).even? ? black_bg(white_pieces(name)) : white_bg(white_pieces(name))
    end
  end

  def place_black_pieces(set)
    set.each do |piece|
      x = piece.position[0]
      y = piece.position[1]
      name = piece.class.name.downcase
      @display[y][x] = (x + y).even? ? black_bg(black_pieces(name)) : white_bg(black_pieces(name))
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
