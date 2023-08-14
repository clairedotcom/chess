require_relative 'rook'

class MoveReferee

  def initialize(game_state, piece, move)
    @game_state = game_state # array of all pieces currently on the board
    @piece = piece # piece object that the user has selected to move
    @move = move # move object the user has selected
  end

  # top-level function delegates to other functions that check each type
  # of piece
  def move_valid
    case @piece
    when Bishop
      check_bishop
    when King
      check_king
    when Knight
      check_knight
    when Pawn
      check_pawn
    when Queen
      check_queen
    when Rook
      check_rook
    else
      false
    end
  end

  def check_bishop
    @piece.move_set.each do |direction|
      temp_position = @piece.position.clone
      while (0..7).include?(temp_position[0]) && (0..7).include?(temp_position[1]) do
        temp_position[0] += direction[0]
        temp_position[1] += direction[1]
        if occupied_by_any_piece?(temp_position) && temp_position != @move.dest
          break
        elsif temp_position == @move.dest
          update_piece
          @move.type = :basic
          return
        end
      end
    end
  end

  def check_king
    @piece.move_set.each do |step|
      if @move.origin[0] + step[0] == @move.dest[0] && @move.origin[1] + step[1] == @move.dest[1]
        if occupied_by_opposite_color?(@move.dest)
          update_piece
          @move.type = :capture
        elsif occupied_by_same_color?(@move.dest)
          break
        else
          update_piece
          @move.type = :basic
        end
      end
    end
  end

  def check_knight
    @piece.move_set.each do |step|
      if @move.origin[0] + step[0] == @move.dest[0] && @move.origin[1] + step[1] == @move.dest[1]
        if occupied_by_opposite_color?(@move.dest)
          update_piece
          @move.type = :capture
        else
          update_piece
          @move.type = :basic
        end
      end
    end
  end

  def check_pawn
    # two square move if the piece has not moved
    # diagonal allowed if it's a capture
    # otherwise single square in the forward direction allowed
    if @piece.move_count == 0
      #move origin, add first element in move set array, see if it equals destination
      @piece.move_set.each do |step|
        if @move.origin[0] + step[0] == @move.dest[0] && @move.origin[1] + step[1] == @move.dest[1]
          set_pawn_move_type(step)
        end
      end
    else
      # two square move not allowed
      @piece.move_set.each do |step|
        if @move.origin[0] + step[0] == @move.dest[0] && @move.origin[1] + step[1] == @move.dest[1] && step[1] != 2
          set_pawn_move_type(step)
        end
      end
    end
  end

  # Helper method used in check pawn
  # Checks if a move is diagonal and if there's a piece in the diagonal space
  # If it's not a diagonal move, sets the move type as basic
  def set_pawn_move_type(step)
    if step[0] != 0 && step[1] != 0
      if occupied_by_opposite_color?(@move.dest)
        update_piece
        @move.type = :capture
      end
    else
      update_piece
      @move.type = :basic
    end
  end

  # Helper method to reuse code in piece checking methods. Incremenets move count,
  # sets move valid tp true, and updates the pawn's position.
  def update_piece
    @piece.move_count += 1
    @piece.position = @move.dest
    @move.valid = true
  end

  def check_queen
    @piece.move_set.each do |direction|
      temp_position = @piece.position.clone
      while (0..7).include?(temp_position[0]) && (0..7).include?(temp_position[1]) do
        temp_position[0] += direction[0]
        temp_position[1] += direction[1]
        if occupied_by_any_piece?(temp_position) && temp_position != @move.dest
          break
        elsif temp_position == @move.dest
          update_piece
          @move.type = :basic
          return
        end
      end
    end
  end

  def check_rook
    @piece.move_set.each do |direction|
      temp_position = @piece.position.clone
      while (0..7).include?(temp_position[0]) && (0..7).include?(temp_position[1]) do
        temp_position[0] += direction[0]
        temp_position[1] += direction[1]
        if occupied_by_any_piece?(temp_position) && temp_position != @move.dest
          break
        elsif temp_position == @move.dest
          update_piece
          @move.type = :basic
          return
        end
      end
    end
  end

  # def legal_moves(possible_moves)
  #   return add_king_castle_moves(possible_moves) if @piece.is_a? King
  # end

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
