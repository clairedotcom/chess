# Super class of individual piece types. Contains data that is common to
# all piece classes.

class Piece
  attr_reader :color
  attr_accessor :position

  def initialize(position, color)
    @position = position
    @color = color
    @move_count = 0
  end
end
