#require_relative 'rook'

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

  private

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
    if is_castle_move?
      update_castled_king
    else 
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

  def update_castled_king
    if white_king_side
      rook = @game_state.select { |piece| piece.position == [7,0] }
      @piece.position = @move.dest
      rook[0].position = [5,0] #select returns an array containing the rook
    elsif black_king_side
      rook = @game_state.select { |piece| piece.position == [7,7] }
      @piece.position = @move.dest
      rook[0].position = [5,7] #select returns an array containing the rook
    elsif white_queen_side
      rook = @game_state.select { |piece| piece.position == [0,0] }
      @piece.position = @move.dest
      rook[0].position = [3,0]
    elsif black_queen_side
      rook = @game_state.select { |piece| piece.position == [0,7] }
      @piece.position = @move.dest
      rook[0].position = [3,7]
    end
    @piece.move_count += 1
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
  def is_castle_move?
    (@piece.move_count == 0) && castling_pieces && (white_king_side || black_king_side || white_queen_side || black_queen_side)
  end

  def white_king_side
    rook = @game_state.select { |piece| piece.position == [7,0] }
    rook_move_count = rook[0]&.move_count
    white_king_side_free? && (rook_move_count == 0)
  end

  def white_queen_side
    rook = @game_state.select { |piece| piece.position == [0,0] }
    rook_move_count = rook[0]&.move_count
    white_queen_side_free? && (rook_move_count == 0)
  end

  def black_king_side
    rook = @game_state.select { |piece| piece.position == [7,7] }
    rook_move_count = rook[0]&.move_count
    black_king_side_free? && (rook_move_count == 0)
  end

  def black_queen_side
    rook = @game_state.select { |piece| piece.position == [0,7] }
    rook_move_count = rook[0]&.move_count
    black_queen_side_free? && (rook_move_count == 0)
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

  def castling_pieces
    (@piece.is_a? King) || (@piece.is_a? Rook)
  end

  #check

  def king_in_check?
    #get king location    
    #get all legal moves for opposing piece
    #if king location is in the list of legal moves,
      #check if the proposed move will remedy check
      #set move valid to false
      #print message about moving to protect king
  end

  def possible_moves
    #iterate through all pieces and calculate all of their valid moves
  end

  def get_king_location
    @game_state.each do |piece|
      return piece.position if piece.is_a? King && piece.color == @piece.color
    end
  end
end
