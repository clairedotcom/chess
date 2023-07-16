require_relative 'utilities'
require_relative 'piece'

class Queen < Piece
  attr_reader :icon

  def initialize(position, color)
    super(position, color)
    @icon = set_icon
  end

  def set_icon
    @color == :white ? "\e[37m\u265B \e[0m" : "\e[30m\u265B \e[0m"
  end

  def move_set
    [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]
  end
end
