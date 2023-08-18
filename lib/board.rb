require_relative 'king'
require_relative 'queen'
require_relative 'bishop'
require_relative 'knight'
require_relative 'rook'
require_relative 'pawn'

# This class stores data about the location of the chess pieces on the board.
# It's responsible for updating the location of the pieces on the board when
# told to do so by the Game class

class Board
  attr_reader :state

  def initialize
      @state = Array.new(8) { Array.new(8, nil) }
      @print_string = Array.new(8) { Array.new(8, " ") }
      set_initial_positions
  end

  # x and y are flipped because x as you're looking at the board is the index of the subarray
  def get_square(x, y)
    @state[y][x]
  end

  # takes origin and destination in form [x, y]
  def update_board(origin, destination)
    #@state[destination.last][destination.first] = get_square(origin.first, origin.last)
    #@state[origin.last][origin.first] = nil
    @state.each_with_index do |row, x|
      row.each_with_index do |piece, y|
        if piece && (piece.position != [y,x])
          @state[piece.position[1]][piece.position[0]] = piece
          @state[x][y] = nil
        end
      end
    end
  end

  def print_board
    reset_print_string
    generate_board_string
    add_column_labels
    add_row_labels
    print_to_console
  end

  # finds king of given color and returns its position. if no king, return false
  def find_king_location(color)
    @state.flatten.each do |element|
        if element.is_a?(King) && element.color == color
            return element.position
        else
            return false
        end
    end
  end

  # takes board position in form [x, y]
  def delete_piece(position)
    @state[position.last][position.first] = nil
  end

  private

  def generate_board_string
    @state.each_with_index do |row, x|
        row.each_with_index do |col, y|
            if @state[x][y].nil?
                @print_string[x][y] = (x + y).even? ? "\e[44m  \e[0m" : "\e[46m  \e[0m"
            else
                @print_string[x][y] = (x + y).even? ? black_background(@state[x][y].icon) : white_background(@state[x][y].icon)
            end
        end
    end
  end

  def add_column_labels
    letter_labels = ['a ', 'b ','c ', 'd ', 'e ', 'f ', 'g ', 'h']
    @print_string.unshift(letter_labels) # prepend to array
    @print_string.push(letter_labels) # append to array
  end

  def add_row_labels
    numbers = [' ', 1, 2, 3, 4, 5, 6, 7, 8]
    @print_string.each_with_index do |row, i|
        row.unshift(numbers[i])
        row.push(numbers[i])
    end
  end

  def print_to_console
    @print_string.reverse.each do |row|
        puts row.join("")
    end
  end

  def reset_print_string
    @print_string = Array.new(8) { Array.new(8, " ") }
  end

  def set_initial_positions
    place_white_pawns
    place_black_pawns
    place_white_back_row
    place_black_back_row
  end

  def place_white_pawns
    (0).upto(7) { |x| @state[1][x] = Pawn.new([x, 1], :white) }
  end

  def place_black_pawns
    (0).upto(7) { |x| @state[6][x] = Pawn.new([x, 6], :black) }
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

  def black_background(piece)
    "\e[44m#{piece}\e[0m"
  end
  
  def white_background(piece)
    "\e[46m#{piece}\e[0m"
  end
end