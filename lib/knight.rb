require_relative 'utilities'

class Knight
  include Utilities
  attr_accessor :position, :color
  attr_reader :icon

  def initialize(position, color)
    @position = position
    @color = color
    @icon = set_icon
  end

  def set_icon
    @color == :white ? "\e[37m\u265E \e[0m" : "\e[30m\u265E \e[0m"
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
