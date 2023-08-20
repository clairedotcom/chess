require_relative 'piece'

class Knight < Piece
  attr_reader :icon, :possible_moves

  def initialize(position, color)
    super(position, color)
    @icon = set_icon
    @possible_moves = get_possible_moves
  end

  def set_icon
    @color == :white ? "\e[37m\u265E \e[0m" : "\e[30m\u265E \e[0m"
  end

  def move_set
    [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
  end

  def get_possible_moves
    squares = move_set.map { |step| [@position[0] + step[0], @position[1] + step[1]]}
    squares.delete_if { |square| !((0..7).include?(square[0]) && (0..7).include?(square[1])) }
  end
end
