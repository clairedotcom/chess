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

  end

  def solicit_move
    piece = solicit_piece_name
    solicit_coordinates(piece)
  end

  def solicit_piece_name
    puts 'Which piece would you like to move? Enter the piece (e.g. rook): '

    loop do
      name = gets.chomp
      return name if valid_name?(name)

      puts 'Invalid piece name. Please enter a piece name: '
    end
  end

  def solicit_coordinates(piece)
    puts "Please enter the square you want to move the #{piece} to (e.g. a4): "

    loop do
      coords = gets.chomp
      return coords if valid_coords?(coords)

      puts 'Invalid input. Please enter the square number and letter (e.g. f5): '
    end
  end

  def verified_move
    # check that move is in chess notation using MoveValidator
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
