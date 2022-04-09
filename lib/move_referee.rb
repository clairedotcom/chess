require_relative 'move_validator'

class MoveReferee
  include MoveValidator

  def initialize(game_state, piece, move)
    @game_state = game_state # array of all pieces currently on the board
    @piece = piece # piece object that the user has selected to move
    @move = move # array in form [[x,y], [x,y]] of the move the user has selected
  end

  def move_valid
    possible_moves = @piece.moves
    possible_moves.delete_if { |square| occupied_by_same_color?(square) }

    return true if legal_moves(possible_moves, @piece).include?(@move.last)

    false
  end

  def legal_moves(possible_moves, piece)
    # return add_king_castle_moves(possible_moves) if piece.is_a? King # need add_king_castle_moves
    return possible_moves if piece.is_a? King
    return possible_moves if piece.is_a? Knight
    return rook_bishop_move_iterator(piece) if piece.is_a? Rook
    return rook_bishop_move_iterator(piece) if piece.is_a? Bishop
    return queen_move_iterator(piece) if piece.is_a? Queen
    # return add_diagonal_pawn_moves(possible_moves, piece) if piece.is_a? Pawn
    return possible_moves if piece.is_a? Pawn
  end

  def add_diagonal_pawn_moves(possible_moves, piece)
    possible_moves.delete_if { |square| occupied_by_opposite_color?(square) } # need occupied by opposite color
    possible_moves.delete_at(0) if occupied_by_any_piece?(possible_moves[1]) # need occupied by any piece
    possible_moves << piece.left_diagonal if occupied_by_opposite_color?(piece.left_diagonal) # same as 1
    possible_moves << piece.right_diagonal if occupied_by_opposite_color?(piece.right_diagonal) # same as 1
    possible_moves
  end

  def occupied_by_opposite_color?(square)
    true if color_of_piece_in_square(square) != @piece.color
    # player = @current_player == @player1 ? @player2 : @player1
    # player.set.any? { |piece| piece.position == square }
  end

  def occupied_by_same_color?(square)
    # @current_player.set.any? { |piece| piece.position == square }
    return false if square_empty?(square)
  end

  def color_of_piece_in_square(square)
  end

  def square_empty?(square)
    false if @game_state.any? { |piece| piece.position == square }
  end

  def select_piece_at(square)
    @game_state.select { |piece| piece.position == square }
  end
end
