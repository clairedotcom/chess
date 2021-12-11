require_relative 'display_generator'

class Board
  include DisplayGenerator

  attr_accessor :display

  def initialize
    @display = Array.new(8) { Array.new(8, ' ') }
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
end
