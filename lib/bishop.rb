require_relative '../lib/move_validator'

class Bishop
  include MoveValidator
  attr_accessor :position

  def initialize(position)
    @position = position
  end

  def moves
    possible_moves = []
    x = @position[0]
    y = @position[1]

    (7).downto(1) { |num| possible_moves << [x + num, y + num] }
    (7).downto(1) { |num| possible_moves << [x - num, y + num] }
    (7).downto(1) { |num| possible_moves << [x - num, y - num] }
    (7).downto(1) { |num| possible_moves << [x + num, y - num] }

    possible_moves.delete_if { |move| off_board?(move) }
  end

  def adjacents
    x = @position[0]
    y = @position[1]

    squares = [[x + 1, y + 1], [x - 1, y + 1], [x - 1, y - 1], [x + 1, y - 1]]
    squares.delete_if { |square| off_board?(square) }
  end
end
