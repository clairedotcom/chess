require_relative 'player'
require_relative 'board'
require_relative 'notation_translator'
require_relative 'dialogue'
require_relative 'game_serializer'

class Game
  include NotationTranslator
  include MoveValidator
  include Dialogue
  include GameSerializer

  attr_accessor :save, :player1, :player2, :board, :current_player

  def initialize
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    @board = Board.new
    @current_player = @player1
    @save = false
  end

  def select_game_mode
    puts select_mode_message

    loop do
      user_input = gets.chomp.to_i
      load_game if user_input == 2
      break if [1, 2].include?(user_input)

      puts invalid_mode_input_message
    end
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
      puts 'check' if check?

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
    king_location = @current_player.find_king_location
    all_moves = find_all_moves(opposite_player)

    return true if all_moves.include?(king_location)
  end

  def find_all_moves(player)
    all_moves = []
    player.set.each do |piece|
      all_moves << legal_moves(piece.moves, piece)
    end
    all_moves.flatten!(1)
    all_moves.delete_if { |square| player.id == color_of_piece_in_square(square) }
    all_moves
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

  def opposite_player
    @current_player == @player1 ? @player2 : @player1
  end

  # Methods to check if moves are legal and generate legal moves

  def valid_move_for_piece?(start, finish)
    piece = @current_player.get_piece_at(start)
    possible_moves = piece.moves
    possible_moves.delete_if { |square| occupied_by_same_color?(square) }

    return true if legal_moves(possible_moves, piece).include?(finish)

    false
  end

  def legal_moves(possible_moves, piece)
    return add_king_castle_moves(possible_moves) if piece.is_a? King
    return possible_moves if piece.is_a? Knight
    return rook_bishop_move_iterator(piece) if piece.is_a? Rook
    return rook_bishop_move_iterator(piece) if piece.is_a? Bishop
    return queen_move_iterator(piece) if piece.is_a? Queen
    return add_diagonal_pawn_moves(possible_moves, piece) if piece.is_a? Pawn
  end

  def add_diagonal_pawn_moves(possible_moves, piece)
    possible_moves.delete_if { |square| occupied_by_opposite_color?(square) }
    possible_moves.delete_at(0) if occupied_by_any_piece?(possible_moves[1])
    possible_moves << piece.left_diagonal if occupied_by_opposite_color?(piece.left_diagonal)
    possible_moves << piece.right_diagonal if occupied_by_opposite_color?(piece.right_diagonal)
    possible_moves
  end

  def add_king_castle_moves(possible_moves)
    possible_moves << king_side_castle unless king_side_castle.nil?
    possible_moves << queen_side_castle unless queen_side_castle.nil?
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
    # return true if @board.color_in_square(square) == @current_player.id

    false
  end

  def color_of_piece_in_square(square)
    return :white if @player1.set.any? { |piece| piece.position == square }
    return :black if @player2.set.any? { |piece| piece.position == square }

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
