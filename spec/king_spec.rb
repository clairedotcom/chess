require_relative '../lib/king'

describe King do
  subject(:test_king) { described_class.new([4, 0], :white) }

  describe '#set_icon' do
    context 'when initialized' do
      it 'returns the correct icon string' do
        expected_icon = "\e[37m\u265A \e[0m"
        expect(test_king.icon).to eq(expected_icon)
      end
    end
  end

  describe '#get_possible_moves' do
    context 'when a white king is at its initial position' do
      it 'returns the correct array of squares' do
        king = King.new([4, 0], :white)
        correct_squares = [[3, 0], [3, 1], [4, 1], [5, 1], [5, 0]]
        expect(king.get_possible_moves).to match_array(correct_squares)
      end
    end

    context 'when a black king is at its initial position' do
      it 'returns the correct array of squares' do
        king = King.new([4, 7], :black)
        correct_squares = [[3, 7], [3, 6], [4, 6], [5, 6], [5, 7]]
        expect(king.get_possible_moves).to match_array(correct_squares)
      end
    end
  end
end
