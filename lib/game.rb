require_relative 'player'
require_relative 'notation_translator'
require_relative 'dialogue'
require_relative 'game_serializer'
require_relative 'move_referee'
require_relative 'display'

class Game
  include NotationTranslator
  include MoveValidator
  include Dialogue
  include GameSerializer

  attr_accessor :save, :player1, :player2, :current_player

  def initialize
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    @game_state = [@player1.set, @player2.set].flatten
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
    Display.new(@game_state).generate_display

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
      # puts 'check' if check?

      start = solicit_start_square
      break if @save

      finish = @current_player.input_finish_square

      # return [start, finish] if legal_move_for_piece?(start, finish)
      piece = @current_player.get_piece_at(start)
      move = [start, finish]
      referee = MoveReferee.new(@game_state, piece, move)
      return move if referee.move_valid

      puts illegal_move_message
    end
  end

  def solicit_start_square
    user_input = @current_player.input_start_square
    @save = true if user_input == :save
    user_input
  end

  # def check?
  #   king_location = @current_player.find_king_location
  #   all_moves = find_all_moves(opposite_player)

  #   return true if all_moves.include?(king_location)
  # end

  # def find_all_moves(player)
  #   all_moves = []
  #   player.set.each do |piece|
  #     all_moves << legal_moves(piece.moves, piece)
  #   end
  #   all_moves.flatten!(1)
  #   all_moves.delete_if { |square| player.id == color_of_piece_in_square(square) }
  #   all_moves
  # end

  def game_over?
    @player1.loser == true || @player2.loser
  end

  def capture(finish)
    @player1.delete_piece(finish) if occupied_by_opposite_color?(finish) && @current_player == @player2
    @player2.delete_piece(finish) if occupied_by_opposite_color?(finish) && @current_player == @player1
  end

  def update_board(start, finish)
    @current_player.update_set(start, finish) unless king_side_castle?([start, finish]) || queen_side_castle?([start, finish])
    @game_state = [@player1.set, @player2.set].flatten
    Display.new(@game_state).generate_display
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def opposite_player
    @current_player == @player1 ? @player2 : @player1
  end

  def occupied_by_any_piece?(square)
    occupied_by_same_color?(square) || occupied_by_opposite_color?(square)
  end

  def occupied_by_opposite_color?(square)
    player = @current_player == @player1 ? @player2 : @player1
    player.set.any? { |piece| piece.position == square }
  end

  def occupied_by_same_color?(square)
    @current_player.set.any? { |piece| piece.position == square }
  end

  def color_of_piece_in_square(square)
    return :white if @player1.set.any? { |piece| piece.position == square }
    return :black if @player2.set.any? { |piece| piece.position == square }

    false
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
