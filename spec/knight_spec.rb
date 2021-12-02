require_relative '../lib/knight'

describe Knight do
  describe '#moves' do
    context 'when the knight is in its initial position' do
      subject(:knight_b1) { described_class.new([1, 0], :white) }

      it 'returns two possible moves' do
        result = [[2, 2], [3, 1], [0, 2]]
        expect(knight_b1.moves).to eq(result)
      end
    end

    context 'when the knight is in the middle of the board' do
      subject(:knight_e5) { described_class.new([4, 4], :black) }

      it 'returns 8 possible moves' do
        result = [[5, 6], [6, 5], [6, 3], [5, 2], [3, 2], [2, 3], [2, 5], [3, 6]]
        expect(knight_e5.moves).to eq(result)
      end
    end
  end
end
