require_relative 'utilities'
require_relative 'piece'

class Rook < Piece
  include Utilities
  attr_reader :icon

  def initialize(position, color)
    super(position, color)
    @icon = set_icon
  end

  def set_icon
    @color == :white ? "\e[37m\u265C \e[0m" : "\e[30m\u265C \e[0m"
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
