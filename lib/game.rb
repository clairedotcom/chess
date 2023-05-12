require_relative 'player'
require_relative 'dialogue'
require_relative 'game_serializer'
require_relative 'move_referee'
require_relative 'board'
require_relative 'utilities'

class Game
  include Utilities
  include Dialogue
  include GameSerializer

  attr_accessor :save, :player1, :player2, :current_player
  attr_reader :game_state, :board

  def initialize
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    @board = Board.new
    @current_player = @player1
    @save = false
  end

  def select_game_mode
    puts select_mode_message
    user_input = validate_game_mode_input
    load_game if user_input == 2
  end

  def validate_game_mode_input
    loop do
      user_input = gets.chomp.to_i
      return user_input if [1, 2].include?(user_input)

      puts invalid_mode_input_message
    end
  end

  def turn
    loop do
      @board.print_board
      review_move
      break if @save || game_over?

      switch_player
    end
  end

  def review_move
    move = solicit_move
    return if @save

    if king_side_castle?(move)
      @current_player.king_side_castle_move
    elsif queen_side_castle?(move)
      @current_player.queen_side_castle_move
    # elsif check?
      # puts 'You're in check! You must move to protect your King.
      # solicit_move
    else
      capture(move.last)
      update_board(move.first, move.last)
    end
  end

  def solicit_move
    loop do
      @current_player.input_start_square
      if occupied_by_same_color?(@current_player.move.origin)
        @current_player.input_finish_square
        move = [@current_player.move.origin, @current_player.move.dest]
        break if @save

        return move if validate_move(move)
      end

      puts illegal_move_message
    end
  end

  # takes move in form [x, y], creates a referee object, and returns true if move is valid
  def validate_move(move)
    piece = @board.get_square(move[0][0], move[0][1])
    referee = MoveReferee.new(format_board_state, piece, move)
    return true if referee.move_valid
  end

  # Takes board state, removes nil elements, and flattens for use in other methods
  def format_board_state
    @board.state.flatten.delete_if { |element| element.nil? }
  end

  def check?
    king_location = @board.find_king_location(@current_player.id)
    all_moves = find_all_moves(opposite_player)

    return true if all_moves.include?(king_location)
  end

  def find_all_moves(player)
    all_moves = []

    format_board_state.each do |piece|
      referee = MoveReferee.new(format_board_state, piece, [])
      all_moves << referee.legal_moves(piece.moves)
    end

    all_moves.flatten!(1)
    p all_moves
    all_moves.delete_if { |square| player.id == color_of_piece_in_square(square) }
    all_moves
  end

  def game_over?
    @player1.loser || @player2.loser
  end

  def capture(finish)
    @board.delete_piece(finish) if occupied_by_opposite_color?(finish)
  end

  def update_board(start, finish)
    @board.update_board(start, finish)
  end

  def switch_player
    @current_player = opposite_player
  end

  def opposite_player
    @current_player == @player1 ? @player2 : @player1
  end

  def occupied_by_any_piece?(square)
    occupied_by_same_color?(square) || occupied_by_opposite_color?(square)
  end

  def occupied_by_opposite_color?(square)
    piece = @board.get_square(square[0], square[1])
    if piece.nil?
      return false
    elsif piece.color == opposite_player.id
      return true
    else
      return false
    end
  end

  def occupied_by_same_color?(square)
    piece = @board.get_square(square[0], square[1])
    if piece.nil?
      return false
    elsif piece.color == @current_player.id
      return true
    else
      return false
    end
  end

  # version of occupied_by_same_color that uses @board
  # expects square in format [x, y]
  def same_color?(square)
    x = square[0].to_i
    y = square[1].to_i
    if @board.get_square(x, y).nil?
      return false
    elsif @board.get_square(x, y).color == @current_player.id
      return true
    else
      return false
    end
  end

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
end
