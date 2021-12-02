require_relative '../lib/move_validator'
require_relative '../lib/bishop'
require_relative '../lib/rook'

class Queen
  attr_accessor :position, :color

  def initialize(position, color)
    @position = position
    @color = color
  end

  def moves
    possible_moves = []

    dummy_rook = Rook.new(@position, @color)
    dummy_bishop = Bishop.new(@position, @color)

    possible_moves << dummy_rook.moves
    possible_moves << dummy_bishop.moves
  end

  def line1
    rook_line1 = Rook.new(@position, @color)
    rook_line1.line1
  end

  def line2
    rook_line2 = Rook.new(@position, @color)
    rook_line2.line2
  end

  def line3
    rook_line3 = Rook.new(@position, @color)
    rook_line3.line3
  end

  def line4
    rook_line4 = Rook.new(@position, @color)
    rook_line4.line4
  end

  def line5
    bishop_line1 = Bishop.new(@position, @color)
    bishop_line1.line1
  end

  def line6
    bishop_line2 = Bishop.new(@position, @color)
    bishop_line2.line2
  end

  def line7
    bishop_line3 = Bishop.new(@position, @color)
    bishop_line3.line3
  end

  def line8
    bishop_line4 = Bishop.new(@position, @color)
    bishop_line4.line4
  end
end
