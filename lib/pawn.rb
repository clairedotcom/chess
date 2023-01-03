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

  def left_diagonal
    result = [@position[0] - 1, @position[1] + 1] if @color == :white
    result = [@position[0] + 1, @position[1] - 1] if @color == :black

    return nil if off_board?(result)

    result
  end

  def right_diagonal
    result = [@position[0] + 1, @position[1] + 1] if @color == :white
    result = [@position[0] - 1, @position[1] - 1] if @color == :black

    return nil if off_board?(result)

    result
  end

  def moves
    return white_pawn if @color == :white
    return black_pawn if @color == :black
  end

  def white_pawn
    possible_moves = []

    possible_moves << [@position[0], @position[1] + 2] if first_move?
    possible_moves << [@position[0], @position[1] + 1]

    possible_moves.delete_if { |move| off_board?(move) }
  end

  def black_pawn
    possible_moves = []

    possible_moves << [@position[0], @position[1] - 2] if first_move?
    possible_moves << [@position[0], @position[1] - 1]

    possible_moves.delete_if { |move| off_board?(move) }
  end

  def first_move?
    return true if @initial == @position

    false
  end
end
