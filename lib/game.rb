require_relative '../lib/player'
require_relative '../lib/board'

class Game
  def initialize
    @player1 = Player.new('white')
    @player2 = Player.new('black')
    @board = Board.new
    @record = nil
    @current_player = @player1
  end

  def play_chess
    intro_dialogue
  end

  def turn
    puts 'Please enter a move in chess notation: '
    input_move
  end

  def input_move
    # asks user to input move in chess notation
    # loops until move is on the board and available
    # send message to update record
    loop do
      move = gets.chomp
      return move if on_board? && is_free?

      puts 'Invalid input. Please enter a move in chess notation: '
    end
  end

  def update_board(piece, move)
    # piece is a string with the name of the piece, move is the coordinates
    @current_player.update_set(piece, move)
    @board.create_display
  end

  def switch_player
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  def update_record
    # add the user's move to the record
  end

  def on_board?
    # checks if move is on the chess board
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

  def translate
    # takes chess notation and outputs as xy coordinates
  end

  private

  def intro_dialogue
    puts 'Welcome to chess!'
  end

  def chess_notation
    # guide to chess notation
  end
end
