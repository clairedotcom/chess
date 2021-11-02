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
    loop do
      move = solicit_move
      update_board(move[0], move[1])
      switch_player
    end
  end

  def solicit_move
    piece = name_to_class(solicit_piece_name)

    loop do
      square = solicit_square(piece)
      move = decode_coords(square)

      return [piece, move] if valid_move_for_piece?(piece, move)

      puts "That move is not valid for the #{piece}. Please try again."
    end
  end

  def solicit_piece_name
    puts 'Which piece would you like to move? Enter the piece (e.g. rook): '

    loop do
      name = gets.chomp
      return name if valid_name?(name)

      puts 'Invalid piece name. Please enter a piece name: '
    end
  end

  def solicit_square(piece)
    puts "Which square do you want to move the #{piece} to? (e.g. a4): "

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

  def is_free?
    # checks if move has no other piece in it
  end

  def game_over?
    # if check mate, game over
  end

  def check?
    # is either player in check?
    # if so, send message to force player in check to protect king
  end

  private

  def intro_dialogue
    puts 'Welcome to chess!'
  end
end
