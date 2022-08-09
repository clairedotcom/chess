# This class stores data about the location of the chess pieces on the board
require_relative 'king'
require_relative 'queen'
require_relative 'bishop'
require_relative 'knight'
require_relative 'rook'
require_relative 'pawn'

class Board
    attr_reader :state

    def initialize
        @state = set_initial_positions
    end

    private

    def set_initial_positions
        @state = Array.new(8) { Array.new(8, nil) }
        place_white_pawns
        place_black_pawns
        place_white_back_row
        place_black_back_row
    end

    def place_white_pawns
        (0).upto(7) { |x| @state[1][x] = Pawn.new([x, 1], :white) }
    end

    def place_black_pawns
        (0).upto(7) { |x| @state[6][x] Pawn.new([x, 6], :black) }
    end

    def place_white_back_row
        @state[0][0] = Rook.new([0, 0], :white)
        @state[0][7] = Rook.new([7, 0], :white)
        @state[0][1] = Knight.new([1, 0], :white)
        @state[0][6] = Knight.new([6, 0], :white)
        @state[0][2] = Bishop.new([2, 0], :white)
        @state[0][5] = Bishop.new([5, 0], :white)
        @state[0][3] = Queen.new([3, 0], :white)
        @state[0][4] = King.new([4, 0], :white)
    end

    def place_black_back_row
        @state[7][0] = Rook.new([0, 7], :black)
        @state[7][7] = Rook.new([7, 7], :black)
        @state[7][1] = Knight.new([1, 7], :black)
        @state[7][6] = Knight.new([6, 7], :black)
        @state[7][2] = Bishop.new([2, 7], :black)
        @state[7][5] = Bishop.new([5, 7], :black)
        @state[7][3] = Queen.new([3, 7], :black)
        @state[7][4] = King.new([4, 7], :black)
    end
end