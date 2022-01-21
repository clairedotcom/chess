# Remaining to-do
Fix issue where pawn can hop if it's pawn's first move

Castling
En passant
Pawn promotion
Check: make other player move to protect king
testing for game class to make future refactoring easier

Make a square object that stores position and color, and use color to make display
Movement classes instead of movement within the piece classes

Continuous improvement:
add turn counter to make sure castling happens only if neither piece has moved

store pieces and positions as a hash within Player for easier access?
Instead of iterating over @set in every single method?
or get rid of @set all together and just have a bunch of pieces?