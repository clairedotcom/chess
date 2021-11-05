require_relative '../lib/move_validator'
require_relative '../lib/bishop'
require_relative '../lib/rook'

class Queen
  attr_accessor :position

  def initialize(position)
    @position = position
  end

  def moves
    possible_moves = []

    dummy_rook = Rook.new(@position)
    dummy_bishop = Bishop.new(@position)

    possible_moves << dummy_rook.moves
    possible_moves << dummy_bishop.moves
  end

  def adjacents
    squares = []

    dummy_rook = Rook.new(@position)
    dummy_bishop = Bishop.new(@position)

    squares << dummy_rook.adjacents
    squares << dummy_bishop.adjacents
  end
end
