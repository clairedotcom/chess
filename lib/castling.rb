module Castling
  def king_side_castle_move
    case @id
    when :white
      make_white_kingside_move
    when :black
      make_black_kingside_move
    end
  end
    
  def queen_side_castle_move
    case @id
    when :white
      make_white_queenside_move
    when :black
      make_black_queenside_move
    end
  end
    
  def make_white_kingside_move
    @set.each do |piece|
      piece.position = [5, 0] if piece.position == [7, 0]
      piece.position = [6, 0] if piece.position == [4, 0]
    end
  end
    
  def make_white_queenside_move
    @set.each do |piece|
      piece.position = [3, 0] if piece.position == [0, 0]
      piece.position = [2, 0] if piece.position == [4, 0]
    end
  end
    
  def make_black_kingside_move
    @set.each do |piece|
      piece.position = [5, 7] if piece.position == [7, 7]
      piece.position = [6, 7] if piece.position == [4, 7]
    end
  end
    
  def make_black_queenside_move
    @set.each do |piece|
      piece.position = [3, 7] if piece.position == [0, 7]
      piece.position = [2, 7] if piece.position == [4, 7]
    end
  end
end
