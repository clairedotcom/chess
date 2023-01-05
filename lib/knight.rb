require_relative 'utilities'
require_relative 'piece'

class Knight < Piece
  include Utilities
  attr_reader :icon

  def initialize(position, color)
    super(position, color)
    @icon = set_icon
  end

  def set_icon
    @color == :white ? "\e[37m\u265E \e[0m" : "\e[30m\u265E \e[0m"
  end

  def move_set
    [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
  end

  def moves
    possible_moves = []
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
