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

  describe '#moves' do
    context 'when given an initial position of [4, 0]' do
      it 'generates a diagonal move one square away' do
        right_diagonal = [5, 1]
        result = test_king.moves
        expect(result).to include right_diagonal
      end

      it 'does not generate a diagonal move off the board' do
        off_board = [3, -1]
        result = test_king.moves
        expect(result).not_to include off_board
      end

      it 'generates a horizontal move one square away' do
        horizontal = [5, 0]
        result = test_king.moves
        expect(result).to include horizontal
      end

      it 'generates a vertical move one square away' do
        vertical = [4, 1]
        result = test_king.moves
        expect(result).to include vertical
      end

      it 'does not return a move more than two squares away' do
        two_squares = [6, 0]
        result = test_king.moves
        expect(result).not_to include two_squares
      end
    end
  end
end
