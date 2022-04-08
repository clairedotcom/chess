require_relative 'display'

class Board
  attr_accessor :display
  attr_reader :data

  def initialize
    @display = Array.new(8) { Array.new(8, ' ') }
    @data = Array.new(8) { Array.new(8) }
  end

  def create_display(white_set, black_set)
    piece_positions = [white_set, black_set].flatten
    Display.new(piece_positions).generate_display
  end

  # def set_initial_data
  #   initialize_pawns(1, :white)
  #   initialize_pawns(6, :black)
  #   initialize_back_row(0, :white)
  #   initialize_back_row(7, :black)
  # end

  # def initialize_pawns(y, color)
  #   (0).upto(7) { |x| @data[x][y] = Pawn.new([x, y], color) }
  # end

  # def initialize_back_row(x, color)
  #   @data[0][x] = Rook.new([0, x], color)
  #   @data[7][x] = Rook.new([7, x], color)
  #   @data[1][x] = Knight.new([1, x], color)
  #   @data[6][x] = Knight.new([6, x], color)
  #   @data[2][x] = Bishop.new([2, x], color)
  #   @data[5][x] = Bishop.new([5, x], color)
  #   @data[3][x] = Queen.new([3, x], color)
  #   @data[4][x] = King.new([4, x], color)
  # end

  def color_in_square(square)
    piece = @data[square[0]][square[1]]

    return false if piece.nil?

    piece.color
  end
end
