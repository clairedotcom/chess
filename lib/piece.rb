# Super class of individual piece types. Contains shared behavior

class Piece
  attr_reader :color
  attr_accessor :position

  def initialize(position, color)
    @position = position
    @color = color
  end
end
