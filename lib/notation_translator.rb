module NotationTranslator
  def notation_to_coordinates(input)
    [decode_piece(input), decode_coords(input)]
  end

  def decode_piece(input)
    letter = input[0]
    Pawn if ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'].include?(letter)
    decode_non_pawns(input)
  end

  def decode_non_pawns(input)
    first = input[0]

    case first
    when 'K'
      piece = King
    when 'Q'
      piece = Queen
    when 'R'
      piece = Rook
    when 'B'
      piece = Bishop
    when 'N'
      piece = Knight
    end
    piece
  end

  def decode_coords(input)
    input.slice!(0) if input.length == 3
    x = 0
    letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']

    letters.each_with_index do |letter, index|
      x = index if letter == input[0]
    end

    y = input[-1].to_i - 1
    [x, y]
  end
end
