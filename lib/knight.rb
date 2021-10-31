require_relative '../lib/move_validator'

class Knight
  include MoveValidator
  attr_accessor :position

  def initialize(position)
    @position = position
  end

  def moves
    possible_moves = Array.new
    x = @position[0]
    y = @position[1]

    possible_moves << [x + 1, y + 2]
    possible_moves << [x + 2, y + 1]
    possible_moves << [x + 2, y - 1]
    possible_moves << [x + 1, y - 2]
    possible_moves << [x - 1, y - 2]
    possible_moves << [x - 2, y - 1]
    possible_moves << [x - 2, y + 1]
    possible_moves << [x - 1, y + 2]

    possible_moves.delete_if { |move| off_board?(move) }
  end
end
