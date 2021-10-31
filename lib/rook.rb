require_relative '../lib/move_validator'

class Rook
  include MoveValidator
  attr_accessor :position

  def initialize(position)
    @position = position
  end

  def moves
    possible_moves = []
    x = @position[0]
    y = @position[1]

    (7).downto(1) { |num| possible_moves << [x + num, y] }
    (7).downto(1) { |num| possible_moves << [x, y + num] }
    (7).downto(1) { |num| possible_moves << [x - num, y] }
    (7).downto(1) { |num| possible_moves << [x, y - num] }

    possible_moves.delete_if { |move| off_board?(move) }
  end
end
