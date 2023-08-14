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

  def moves
    possible_moves = []
    x = @position[0]
    y = @position[1]

    possible_moves << [x, y + 1]
    possible_moves << [x + 1, y + 1]
    possible_moves << [x + 1, y]
    possible_moves << [x + 1, y - 1]
    possible_moves << [x, y - 1]
    possible_moves << [x - 1, y - 1]
    possible_moves << [x - 1, y]
    possible_moves << [x - 1, y + 1]

    possible_moves.delete_if { |move| off_board?(move) }
  end
end
