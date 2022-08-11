require_relative 'utilities'

class MoveReferee
  include Utilities

  def initialize(game_state, piece, move)
    @game_state = game_state # array of all pieces currently on the board
    @piece = piece # piece object that the user has selected to move
    @move = move # array in form [[x,y], [x,y]] of the move the user has selected
  end

  def move_valid
    possible_moves = @piece.moves
    possible_moves.delete_if { |square| occupied_by_same_color?(square) }

    return true if legal_moves(possible_moves).include?(@move.last)

    false
  end

  def legal_moves(possible_moves)
    return add_king_castle_moves(possible_moves) if @piece.is_a? King
    return possible_moves if @piece.is_a? Knight
    return rook_bishop_move_iterator(@piece) if @piece.is_a? Rook
    return rook_bishop_move_iterator(@piece) if @piece.is_a? Bishop
    return queen_move_iterator(@piece) if @piece.is_a? Queen
    return add_diagonal_pawn_moves(possible_moves) if @piece.is_a? Pawn
  end

  def add_diagonal_pawn_moves(possible_moves)
    possible_moves.delete_if { |square| occupied_by_opposite_color?(square) }
    possible_moves.delete_at(0) if occupied_by_any_piece?(possible_moves[1])
    possible_moves << @piece.left_diagonal if occupied_by_opposite_color?(@piece.left_diagonal)
    possible_moves << @piece.right_diagonal if occupied_by_opposite_color?(@piece.right_diagonal)
    possible_moves
  end

  def occupied_by_any_piece?(square)
    @game_state.any? { |piece| piece.position == square }
  end

  def occupied_by_opposite_color?(square)
    @game_state.any? { |piece| piece.position == square && piece.color != @piece.color }
  end

  def occupied_by_same_color?(square)
    @game_state.any? { |piece| piece.position == square && piece.color == @piece.color }
  end

  # Castling

  def add_king_castle_moves(possible_moves)
    possible_moves << king_side_castle unless king_side_castle.nil?
    possible_moves << queen_side_castle unless queen_side_castle.nil?
    possible_moves
  end

  def king_side_castle?
    if @piece.color == :white && @move.last == [6, 0]
      true
    elsif @piece.color == :black && @move.last == [6, 7]
      true
    end
  end

  def queen_side_castle?
    if @piece.color == :white && @move.last == [2, 0]
      true
    elsif @piece.color == :black && @move.last == [2, 7]
      true
    end
  end

  def king_side_castle
    return [6, 0] if white_king_side_free? && @piece.color == :white
    return [6, 7] if black_king_side_free? && @piece.color == :black
  end

  def queen_side_castle
    return [2, 0] if white_queen_side_free? && @piece.color == :white
    return [2, 7] if black_queen_side_free? && @piece.color == :black
  end

  def white_king_side_free?
    !occupied_by_any_piece?([5, 0]) && !occupied_by_any_piece?([6, 0])
  end

  def black_king_side_free?
    !occupied_by_any_piece?([5, 7]) && !occupied_by_any_piece?([6, 7])
  end

  def white_queen_side_free?
    !occupied_by_any_piece?([1, 0]) && !occupied_by_any_piece?([2, 0]) && !occupied_by_any_piece?([3, 0])
  end

  def black_queen_side_free?
    !occupied_by_any_piece?([1, 7]) && !occupied_by_any_piece?([2, 7]) && !occupied_by_any_piece?([3, 7])
  end
end
