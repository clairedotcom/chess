module NotationTranslator
  def notation_to_coordinates(input)
    # K is king
    # Q is queen
    # R is rook
    # B is bishop
    # N is knight 
    # output in form ['piece', [x,y]] meaning move piece to x,y
  end

  def decode_piece(input)
    first = input[0]
    piece = pawn if ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'].include?(letter)

    case first
    when 'K'
      piece = 'king'
    when 'Q'
      piece = 'queen'
    when 'R'
      piece = 'rook'
    when 'B'
      piece = 'bishop'
    when 'N'
      piece = 'knight'
    end
    piece
  end
end
