require_relative '../lib/bishop'

describe Bishop do
  subject(:test_bishop) { described_class.new([2, 0], :white) }

  describe '#set_icon' do
    context 'when a white bishop is initialized' do
      it 'returns the correct icon string' do
        icon_string = "\e[37m\u265D \e[0m"
        expect(test_bishop.icon).to eq(icon_string)
      end
    end
  end

  describe '#get_possible_moves' do
    context 'when the white bishop at c1 is at its initial position' do
      it 'returns the correct squares' do
        bishop = Bishop.new([2, 0], :white)
        correct_squares = [[1, 1], [0, 2], [3, 1], [4, 2], [5, 3], [6, 4], [7, 5]]
      end
    end

    context 'when the white bishop at f1 is at its initial position' do
      it 'returns the correct squares' do
        bishop = Bishop.new([5, 0], :white)
        correct_squares = [[6, 1], [7, 2], [4, 1], [3, 2], [2, 3], [1, 4], [0, 5]]
        expect(bishop.get_possible_moves).to match_array(correct_squares)
      end
    end

    context 'when the black bishop at c8 is at its initial position' do
      it 'returns the correct squares' do
        bishop = Bishop.new([2, 7], :black)
        correct_squares = [[1, 6], [0, 5], [3, 6], [4, 5], [5, 4], [6, 3], [7, 2]]
        expect(bishop.get_possible_moves).to match_array(correct_squares)
      end
    end

    context 'when the white bishop at f8 is at its initial position' do
      it 'returns the correct squares' do
        bishop = Bishop.new([5, 7], :black)
        correct_squares = [[6, 6], [7, 5], [4, 6], [3, 5], [2, 4], [1, 3], [0, 2]]
        expect(bishop.get_possible_moves).to match_array(correct_squares)
      end
    end
  end
end
