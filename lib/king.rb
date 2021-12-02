require_relative '../lib/move_validator'

class King
  include MoveValidator
  attr_accessor :position, :color

  def initialize(position, color)
    @position = position
    @color = color
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
