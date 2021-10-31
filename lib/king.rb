require_relative '../lib/move_validator'

class King
  include MoveValidator
  attr_accessor :position

  def initialize(position)
    @position = position
  end

  def moves
    possible_moves = []
    x = @position[0]
    y = @position[1]

    possible_moves << [x, y + 1]
    possible_moves << [x + 1, y + 1]
    possible_moves << [x + 1, y]
    possible_moves << [x + 1, y - 1]
    possible_moves << [x, y - 1]
    possible_moves << [x - 1, y - 1]
    possible_moves << [x - 1, y]
    possible_moves << [x - 1, y + 1]

    possible_moves.delete_if { |move| off_board?(move) }
  end
end
