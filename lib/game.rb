require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/notation_translator'

class Game
  include NotationTranslator
  include MoveValidator

  def initialize
    @player1 = Player.new('white')
    @player2 = Player.new('black')
    @board = Board.new
    @current_player = @player1
  end

  def play_chess
    intro_dialogue
  end

  def turn
    @board.create_display(@player1.set, @player2.set)
    loop do
      move = solicit_move
      update_board(move[0], move[1])
      switch_player
    end
  end

  def solicit_move
    loop do
      start = decode_coords(solicit_start_square)
      finish = decode_coords(solicit_finish_square)

      piece_name = @current_player.get_piece_at(start)
      piece = name_to_class(piece_name)

      return [piece, finish] if valid_move_for_piece?(piece, finish)

      puts "Invalid move for that #{piece}. Please try again."
    end
  end

  def solicit_start_square
    puts "Enter the location of the piece you'd like to move (e.g. a4): "

    loop do
      square = gets.chomp
      return square if valid_coords?(square)

      puts 'Invalid input. Please enter the square number and letter (e.g. f5): '
    end
  end

  def solicit_finish_square
    puts 'Which square would you like to move to (e.g. a4): '

    loop do
      square = gets.chomp
      return square if valid_coords?(square)

      puts 'Invalid input. Please enter the square number and letter (e.g. f5): '
    end
  end

  def update_board(piece, move)
    @current_player.update_set(piece, move)
    @board.create_display(@player1.set, @player2.set)
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def valid_move_for_piece?(piece, move)
    return true if @current_player.move_possible?(piece, move)

    false
  end

  def occupied_by_same_color?(square)
    @current_player.set.each do |piece|
      return true if piece.position == square
    end
    false
  end

  def occupied_by_opposite_color?(square)
    player = @current_player == @player1 ? @player2 : @player1

    player.set.each do |piece|
      return true if piece.position == square
    end
    false
  end

  private

  def intro_dialogue
    puts 'Welcome to chess!'
  end
end
