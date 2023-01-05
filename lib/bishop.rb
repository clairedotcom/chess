require_relative 'utilities'
require_relative 'piece'

class Bishop < Piece
  include Utilities
  attr_reader :icon

  def initialize(position, color)
    super(position, color)
    @icon = set_icon
  end

  def set_icon
    @color == :white ? "\e[37m\u265D \e[0m" : "\e[30m\u265D \e[0m"
  end

  def move_set
    [[1, 1], [-1, 1], [-1, -1], [1, -1]]
  end

  def moves
    [line1, line2, line3, line4].flatten(1)
  end

  def line1
    possible_moves = []
    x = @position[0]
    y = @position[1]
    (1).upto(7) { |num| possible_moves << [x + num, y + num] }
    possible_moves.delete_if { |move| off_board?(move) }
  end

  def line2
    possible_moves = []
    x = @position[0]
    y = @position[1]
    (1).upto(7) { |num| possible_moves << [x - num, y + num] }
    possible_moves.delete_if { |move| off_board?(move) }
  end

  def line3
    possible_moves = []
    x = @position[0]
    y = @position[1]
    (1).upto(7) { |num| possible_moves << [x - num, y - num] }
    possible_moves.delete_if { |move| off_board?(move) }
  end

  def line4
    possible_moves = []
    x = @position[0]
    y = @position[1]
    (1).upto(7) { |num| possible_moves << [x + num, y - num] }
    possible_moves.delete_if { |move| off_board?(move) }
  end
end
