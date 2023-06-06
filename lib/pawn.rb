require_relative 'utilities'
require_relative 'piece'

class Pawn < Piece
  include Utilities
  attr_reader :icon

  def initialize(position, color)
    super(position, color)
    @initial = position
    @icon = set_icon
  end

  def set_icon
    @color == :white ? "\e[37m\u265F \e[0m" : "\e[30m\u265F \e[0m"
  end

  def move_set
    color == :white ? [[0, 1], [0, 2], [-1, 1], [1, 1]] : [[0, -1], [0, -2], [1, -1], [-1, -1]]
  end
end
