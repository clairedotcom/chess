require_relative '../lib/pawn'

describe Pawn do
  describe '#moves' do
    context 'when passed an initial position' do
      subject(:pawn_first) { described_class.new([0, 1]) }

      it 'returns a one square and two square move' do
        result = [[0, 3], [0, 2]]
        expect(pawn_first.moves).to eq(result)
      end
    end

    context 'when the pawn has already moved' do
      subject(:pawn_moved) { described_class.new([3, 3]) }

      it 'returns a one square move' do
        result = [[3, 5]]
        pawn_moved.instance_variable_set(:@position, [3, 4])
        expect(pawn_moved.moves).to eq(result)
      end
    end
  end

  describe '#first_move?' do
    context 'when current position equals initial position' do
      subject(:pawn_true) { described_class.new([7, 1]) }

      it 'returns true' do
        pawn_true.instance_variable_set(:@position, [7, 1])
        expect(pawn_true.first_move?).to be true
      end
    end

    context 'when the current position does not equal initial position' do
      subject(:pawn_false) { described_class.new([6, 1]) }

      it 'returns false' do
        pawn_false.instance_variable_set(:@position, [6, 5])
        expect(pawn_false.first_move?).to be false
      end
    end
  end
end
