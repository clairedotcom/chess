require_relative 'piece'

class King < Piece
  attr_reader :icon

  def initialize(position, color)
    super(position, color)
    @icon = set_icon
  end

  def set_icon
    @color == :white ? "\e[37m\u265A \e[0m" : "\e[30m\u265A \e[0m"
  end

  def move_set
    [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]
  end

  def get_possible_moves
    squares = move_set.map { |step| [@position[0] + step[0], @position[1] + step[1]]}
    squares.delete_if { |square| !((0..7).include?(square[0]) && (0..7).include?(square[1])) }
  end
end
