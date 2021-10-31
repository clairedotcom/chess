require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/king'
require_relative '../lib/queen'
require_relative '../lib/bishop'
require_relative '../lib/knight'
require_relative '../lib/rook'
require_relative '../lib/pawn'

test = Board.new
white_player = Player.new('white')
black_player = Player.new('black')

test.create_display(white_player.set, black_player.set)
white_player.update_set(Knight, [2, 2])
test.create_display(white_player.set, black_player.set)
black_player.update_set(Pawn, [1, 5])
test.create_display(white_player.set, black_player.set)
