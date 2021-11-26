require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/notation_translator'
require_relative '../lib/dialogue'
require_relative '../lib/game_serializer'

class Game
  include NotationTranslator
  include MoveValidator
  include Dialogue
  include GameSerializer

  attr_reader :save

  def initialize
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    @board = Board.new
    @current_player = @player1
    @save = false
  end

  def play_chess
    intro_dialogue
    turn
  end

  def turn
    @board.create_display(@player1.set, @player2.set)

    loop do
      puts announce_current_player
      move = review_move
      break if @save

      update_board(move[0], move[1])
      break if game_over?

      switch_player
    end
  end

  def review_move
    move = solicit_move
    return if @save

    @current_player.king_side_castle_move if king_side_castle?(move)
    @current_player.queen_side_castle_move if queen_side_castle?(move)
    capture(move[1])
    move
  end

  def solicit_move
    loop do
      puts start_square_dialogue

      start = solicit_start_square
      break if @save

      finish = solicit_finish_square

      return [start, finish] if valid_move_for_piece?(start, finish)

      puts illegal_move_message
    end
  end

  def solicit_start_square
    loop do
      user_input = gets.chomp

      if user_input == 'save'
        @save = true
        return
      end

      square = decode_coords(user_input)
      return square if valid_coords?(user_input) && occupied_by_same_color?(square)

      puts invalid_input_message
    end
  end

  def solicit_finish_square
    puts finish_square_dialogue

    loop do
      square = gets.chomp
      return decode_coords(square) if valid_coords?(square)

      puts invalid_input_message
    end
  end

  def check?
    # do any of the opposite player's possible moves contain current player's king?
  end

  def game_over?
    return true if @player1.loser == true || @player2.loser == true

    false
  end

  def capture(finish)
    @player1.delete_piece(finish) if occupied_by_opposite_color?(finish) && @current_player == @player2
    @player2.delete_piece(finish) if occupied_by_opposite_color?(finish) && @current_player == @player1
  end

  def update_board(start, finish)
    @current_player.update_set(start, finish)
    @board.create_display(@player1.set, @player2.set)
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  # Methods to check if moves are legal

  def valid_move_for_piece?(start, finish)
    piece = @current_player.get_piece_at(start)
    possible_moves = piece.moves
    possible_moves.delete_if { |square| occupied_by_same_color?(square) }

    return true if legal_moves(possible_moves, piece).include?(finish)

    false
  end

  def legal_moves(possible_moves, piece)
    piece_name = piece.class.name

    return add_king_castle_moves(possible_moves) if piece_name == 'King'
    return possible_moves if piece_name == 'Knight'
    return rook_bishop_move_iterator(piece) if piece_name == 'Rook'
    return rook_bishop_move_iterator(piece) if piece_name == 'Bishop'
    return queen_move_iterator(piece) if piece_name == 'Queen'
    return add_diagonal_pawn_moves(possible_moves, piece) if piece_name == 'Pawn'
  end

  def add_diagonal_pawn_moves(possible_moves, piece)
    possible_moves.delete_if { |square| occupied_by_opposite_color?(square) }
    possible_moves << piece.left_diagonal if occupied_by_opposite_color?(piece.left_diagonal)
    possible_moves << piece.right_diagonal if occupied_by_opposite_color?(piece.right_diagonal)
    possible_moves
  end

  def add_king_castle_moves(possible_moves)
    possible_moves << king_side_castle
    possible_moves << queen_side_castle
    possible_moves
  end

  # Methods to check squares for pieces

  def occupied_by_any_piece?(square)
    return true if occupied_by_same_color?(square) || occupied_by_opposite_color?(square)

    false
  end

  def occupied_by_opposite_color?(square)
    player = @current_player == @player1 ? @player2 : @player1
    return true if player.set.any? { |piece| piece.position == square }

    false
  end

  def occupied_by_same_color?(square)
    return true if @current_player.set.any? { |piece| piece.position == square }

    false
  end

  # Castling methods

  def king_side_castle?(move)
    if @current_player == @player1 && move[1] == [6, 0]
      true
    elsif @current_player == @player2 && move[1] == [6, 7]
      true
    end
  end

  def queen_side_castle?(move)
    if @current_player == @player1 && move[1] == [2, 0]
      true
    elsif @current_player == @player2 && move[1] == [2, 7]
      true
    end
  end

  def king_side_castle
    return [6, 0] if white_king_side_free? && @current_player == @player1
    return [6, 7] if black_king_side_free? && @current_player == @player2
  end

  def queen_side_castle
    return [2, 0] if white_queen_side_free? && @current_player == @player1
    return [2, 7] if black_queen_side_free? && @current_player == @player2
  end

  def white_king_side_free?
    return false if occupied_by_any_piece?([5, 0]) && occupied_by_any_piece?([6, 0])

    true
  end

  def black_king_side_free?
    return false if occupied_by_any_piece?([5, 7]) && occupied_by_any_piece?([6, 7])

    true
  end

  def white_queen_side_free?
    return false if occupied_by_any_piece?([1, 0]) && occupied_by_any_piece?([2, 0]) && occupied_by_any_piece?([3, 0])

    true
  end

  def black_queen_side_free?
    return false if occupied_by_any_piece?([1, 7]) && occupied_by_any_piece?([2, 7]) && occupied_by_any_piece?([3, 7])

    true
  end
end
