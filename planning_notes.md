# Remaining to-do
Fix issue where pawn can hop if it's pawn's first move

Castling  
En passant  
Pawn promotion  
Check: make other player move to protect king  
testing for game class to make future refactoring easier  

Serialization: load saved game or save game at any time  

Continuous improvement:  
add turn counter to make sure castling happens only if neither piece has moved  

store pieces and positions as a hash within Player for easier access?  
Instead of iterating over @set in every single method?  
or get rid of @set all together and just have a bunch of pieces?  

### Board class
holds data about where all pieces are
-grid: 2D array of nil
~setGrid(): creates piece objects and puts them in their initial positions

### Game class
handles game actions

### Player class
handle user input
-color
-symbol
-position

### Move referee

### Piece class
-position: coordinate
-icon: string
-color: symbol
~move(): takes movement type and if it doesn't work for that piece, return error
~forward()
~left()
~right()
~backward()
~forwardLeft()
~forwardRight()
~backwardLeft()
~backwardRight()
~knight()
