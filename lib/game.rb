require_relative 'player'
require_relative 'dialogue'
require_relative 'game_serializer'
require_relative 'move_referee'
require_relative 'board'

class Game
  include Dialogue
  include GameSerializer

  attr_accessor :save, :player1, :player2, :current_player
  attr_reader :game_state, :board, :turn_count

  def initialize
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    @board = Board.new
    @current_player = @player1
    @save = false
    @turn_count = 0
  end

  def select_game_mode
    puts select_mode_message
    user_input = validate_game_mode_input
    load_game if user_input == 2
  end

  def validate_game_mode_input
    loop do
      user_input = gets.chomp
      exit(true) if user_input == 'quit'
      return user_input.to_i if [1, 2].include?(user_input.to_i)

      puts invalid_mode_input_message
    end
  end

  def turn
    loop do
      @board.print_board
      review_move
      break if @save || game_over?
      switch_player
      @turn_count += 1
    end
  end

  def review_move
    move = solicit_move
    return if @save
    update_board(move.first, move.last)
  end

  def solicit_move
    loop do
      @current_player.input_start_square
      if occupied_by_same_color?(@current_player.move.origin)
        @current_player.input_finish_square
        move = [@current_player.move.origin, @current_player.move.dest]
        break if @save
        validate_move(@current_player.move)
        return move if @current_player.move.valid
      end
      puts illegal_move_message
    end
  end

  # Creates a move referee and returns true if move is valid
  # @param move a Move object for the move the user selected
  # @return true if it's a legal move, false if not
  def validate_move(move)
    piece = @board.get_square(move.origin[0], move.origin[1])
    referee = MoveReferee.new(format_board_state, piece, move)
    referee.move_valid
    if move.type == :en_passant
      board.delete_piece(captured_en_passant_pawn(move, piece))
    end
    return move.valid
  end

  def captured_en_passant_pawn(move, piece)
    if piece.color == :white
      return [move.dest[0], move.dest[1] - 1]
    elsif piece.color == :black
      return [move.dest[0], move.dest[1] + 1]
    end
  end

  # Takes board state, removes nil elements, and flattens for use in other methods
  def format_board_state
    @board.state.flatten.delete_if { |element| element.nil? }
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
end
