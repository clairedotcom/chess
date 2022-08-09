require_relative 'game'
require_relative 'board'
require_relative 'player'
require_relative 'king'
require_relative 'queen'
require_relative 'bishop'
require_relative 'knight'
require_relative 'rook'
require_relative 'pawn'
require_relative 'notation_translator'
require_relative 'game_serializer'
require 'yaml'

# game = Game.new
# game.intro_dialogue
# game.select_game_mode

# until game.game_over?
#   if game.save
#     game.save_game
#     break
#   end

#   game.turn
# end
board = Board.new
board.print_board