require_relative 'piece'

class Bishop < Piece
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

  def get_possible_moves
    squares = []
    7.times do |i|
      move_set.map do |step|
        squares << [@position[0] + (i + 1)*step[0], @position[1] + (i + 1)*step[1]]
      end
    end
    squares.delete_if { |square| !((0..7).include?(square[0]) && (0..7).include?(square[1])) }
  end
end
