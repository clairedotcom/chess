require_relative '../lib/move_validator'

class Rook
  include MoveValidator
  attr_accessor :position

  def initialize(position)
    @position = position
  end

  def moves
    [line1, line2, line3, line4].flatten(1)
  end

  def line1
    line = []
    x = @position[0]
    y = @position[1]

    (1).upto(7) { |num| line << [x + num, y] }
    line.delete_if { |move| off_board?(move) }
  end

  def line2
    line = []
    x = @position[0]
    y = @position[1]

    (1).upto(7) { |num| line << [x, y + num] }
    line.delete_if { |move| off_board?(move) }
  end

  def line3
    line = []
    x = @position[0]
    y = @position[1]

    (1).upto(7) { |num| line << [x - num, y] }
    line.delete_if { |move| off_board?(move) }
  end

  def line4
    line = []
    x = @position[0]
    y = @position[1]

    (1).upto(7) { |num| line << [x, y - num] }
    line.delete_if { |move| off_board?(move) }
  end
end
