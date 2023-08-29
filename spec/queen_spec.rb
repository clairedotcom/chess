require_relative '../lib/queen'

describe Queen do

  describe '#set_icon' do
    context 'when initialized' do
      it 'returns the correct icon string' do
        queen = Queen.new([3, 0], :white)
        icon_string = "\e[37m\u265B \e[0m"
        expect(queen.icon).to eq(icon_string)
      end
    end
  end

  describe '#get_possible_moves' do
    context 'when a white queen is at its initial position' do
      it 'returns the correct array of squares' do
        queen = Queen.new([3, 0], :white)
        correct_squares = [[0, 0], [1, 0], [2, 0], [4, 0], [5, 0], [6, 0], [7, 0],
                            [3, 1], [3, 2], [3, 3], [3, 4], [3, 5], [3, 6], [3, 7],
                            [0, 3], [1, 2], [2, 1], [7, 4], [6, 3], [5, 2], [4, 1]]
        expect(queen.get_possible_moves).to match_array(correct_squares)
      end
    end

    context 'when a black queen is at its initial position' do
      it 'returns the correct array of squares' do
        queen = Queen.new([3, 7], :black)
        correct_squares = [[0, 7], [1, 7], [2, 7], [4, 7], [5, 7], [6, 7], [7, 7],
                           [3, 1], [3, 2], [3, 3], [3, 4], [3, 5], [3, 6], [3, 0],
                           [0, 4], [1, 5], [2, 6], [7, 3], [6, 4], [5, 5], [4, 6]]
        expect(queen.get_possible_moves).to match_array(correct_squares)
      end
    end
  end
end
