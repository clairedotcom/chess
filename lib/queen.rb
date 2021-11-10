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

  def line1
    rook_line1 = Rook.new(@position)
    rook_line1.line1
  end

  def line2
    rook_line2 = Rook.new(@position)
    rook_line2.line2
  end

  def line3
    rook_line3 = Rook.new(@position)
    rook_line3.line3
  end

  def line4
    rook_line4 = Rook.new(@position)
    rook_line4.line4
  end

  def line5
    bishop_line1 = Bishop.new(@position)
    bishop_line1.line1
  end

  def line6
    bishop_line2 = Bishop.new(@position)
    bishop_line2.line2
  end

  def line7
    bishop_line3 = Bishop.new(@position)
    bishop_line3.line3
  end

  def line8
    bishop_line4 = Bishop.new(@position)
    bishop_line4.line4
  end
end
