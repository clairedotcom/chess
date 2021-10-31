require_relative '../lib/move_validator'

class Pawn
  include MoveValidator
  attr_accessor :position

  def initialize(position, color)
    @initial = position
    @position = position
    @color = color
  end

  def moves
    return white_pawn if @color == 'white'
    return black_pawn if @color == 'black'
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
