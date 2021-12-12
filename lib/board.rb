require_relative 'display_generator'

class Board
  include DisplayGenerator

  attr_accessor :display
  attr_reader :data

  def initialize
    @display = Array.new(8) { Array.new(8, ' ') }
    @data = Array.new(8) { Array.new(8, nil) }
  end

  def create_display(white_set, black_set)
    @display.each_with_index do |row, x|
      row.each_with_index do |_col, y|
        @display[x][y] = (x + y).even? ? colorize('black') : colorize('white')
      end
    end
    place_white_pieces(white_set)
    place_black_pieces(black_set)
    print_board
  end

  def set_initial_data(white_set, black_set)
    @data.each_with_index do |row, x|
      row.each_with_index do |_col, y|
        @data[x][y] = white_set.select { |piece| piece.position == [x, y] }
        @data[x][y] = black_set.select { |piece| piece.position == [x, y] }
      end
    end
    @data.flatten!(1)
  end

  def update_data(piece, new_location)
    # Game tells board what piece has changed
    # Board set previous location to nil and new location to piece
  end

  def free?(square)
    # looks at data[square[0]][square[1]] and returns true if it's nil
  end

  def color_in_square(square)
    # looks at data[square[0]][square[1]] and returns the color of the piece in the square
  end
end
