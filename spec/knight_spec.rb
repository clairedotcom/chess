require_relative '../lib/knight'

describe Knight do
  subject(:test_knight) { described_class.new([1, 0], :white) }

  describe '#set_icon' do
    context 'when initialized' do
      it 'returns the correct icon string' do
        expected_icon = "\e[37m\u265E \e[0m"
        expect(test_knight.icon).to eq(expected_icon)
      end
    end
  end

  describe '#moves' do
    context 'when the knight is in its initial position' do
      it 'returns the correct possible moves' do
        result = [[2, 2], [3, 1], [0, 2]]
        expect(test_knight.moves).to eq(result)
      end
    end

    context 'when the knight is in the middle of the board' do
      before do
        test_knight.position = [4, 4]
      end

      it 'returns 8 possible moves' do
        result = [[5, 6], [6, 5], [6, 3], [5, 2], [3, 2], [2, 3], [2, 5], [3, 6]]
        expect(test_knight.moves).to eq(result)
      end
    end
  end
end
