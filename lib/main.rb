require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/king'
require_relative '../lib/queen'
require_relative '../lib/bishop'
require_relative '../lib/knight'
require_relative '../lib/rook'
require_relative '../lib/pawn'
require_relative '../lib/notation_translator'
require_relative '../lib/game_serializer'
require 'yaml'

game = Game.new

until game.game_over?
  if game.save
    game.save_game
    break
  end

  game.turn

end
