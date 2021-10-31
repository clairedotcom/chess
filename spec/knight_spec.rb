require_relative '../lib/knight'

describe Knight do
  describe '#moves' do
    context 'when the knight is in its initial position' do
      subject(:knight_check_moves) { described_class.new([1, 0])}

      it 'returns two possible moves' do
        result = knight_check_moves.moves
        expect(result.length).to eq(3)
      end
    end

    context 'when the knight is in the middle of the board' do
      subject(:knight_middle) { described_class.new([4, 4])}

      it 'returns 8 possible moves' do
        result = knight_middle.moves
        expect(result.length).to eq(8)
      end
    end
  end
end
