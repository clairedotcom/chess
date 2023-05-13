# class to store data about the move a player has selected. move contains
# a start square, a finish square, and a type to describe the move. a
# move is created by the player class and then later checked for validity
# in the context of the game state
# Allowable states: unchecked, invalid, basic, capture, castle, en passant

class Move
  attr_accessor :origin, :dest, :valid, :type

  # Initial move state is unchecked
  # @param origin of move in form [x, y]
  # @param dest destination of move in form [x, y]
  def initialize(origin, dest)
    @origin = origin
    @dest = dest
    @valid = false
    @type = :unchecked
  end

  def update_type(new_type)
    @type = new_type
  end
end