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

puts 'Enter 1 for new game or 2 to load saved game: '
game_mode = gets.chomp

if game_mode == '1'
  game = Game.new
elsif game_mode == '2'
  game = Game.new
  game.load_game
end

until game.game_over?
  if game.save
    game.save_game
    break
  end

  game.turn

end
