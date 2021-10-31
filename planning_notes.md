# Game class
@player1 instance of player class, white
@player2 instance of player class, black
@record = empty array, chess notation of game

use record to generate current state display of board
should record be an array or a hash?
method #input_move user enters move in chess notation


# Player class
@id black or white
@set = Set.new set of all pieces for a player
does it work to make a set generator method to generate the pieces for a new player?


# Board class
@coordinates 8x8 grid that is either nil or a piece
how do I want to represent the board?
64-element array of squares in chess notation?

method #display to show board in terminal

# Set class - delete
@ID = black or white
instance variables for 8 pawns, 2 rooks, 2 knights, 2 bishops, 1 king, 1 queen
do I need this class? is it better to include in the player class?

# Pawn class
@position = starting position
method to generate possible moves

# Rook class
@position = starting position
method to generate possible moves

# Knight class
@position = starting position
method to generate possible moves

# Bishop class
@position = starting position
method to generate possible moves

# Queen class
@position = starting position
method to generate possible moves

# King class
@position = starting position
method to generate possible moves