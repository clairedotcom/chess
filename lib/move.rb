# class to store data about the move a player has selected. move contains
# a start square, a finish square, and a type to describe the move. a
# move is created by the player class and then later checked for validity
# in the context of the game state

class Move
  # Initial move state is unchecked
  # @param start_square origin of move in form [x, y]
  # @param finish_Square destination of move in form [x, y]
  def initialize(start_square, finish_square)
    @start_square = start_square
    @finish_square = finish_square
    @type = :unchecked
  end

  def update_type(new_type)
    @type = new_type
  end
end