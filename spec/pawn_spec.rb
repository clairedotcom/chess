require_relative '../lib/pawn'

describe Pawn do
  describe '#moves' do
    context 'when passed an initial position' do
      subject(:pawn_first) { described_class.new([0, 1], :white) }

      it 'returns a one square and two square move' do
        result = [[0, 3], [0, 2]]
        expect(pawn_first.moves).to eq(result)
      end
    end

    context 'when the pawn has already moved' do
      subject(:pawn_moved) { described_class.new([3, 3], :white) }

      it 'returns a one square move' do
        result = [[3, 5]]
        pawn_moved.instance_variable_set(:@position, [3, 4])
        expect(pawn_moved.moves).to eq(result)
      end
    end
  end

  describe '#first_move?' do
    context 'when current position equals initial position' do
      subject(:pawn_true) { described_class.new([7, 1], :white) }

      it 'returns true' do
        pawn_true.instance_variable_set(:@position, [7, 1])
        expect(pawn_true.first_move?).to be true
      end
    end

    context 'when the current position does not equal initial position' do
      subject(:pawn_false) { described_class.new([6, 1], :white) }

      it 'returns false' do
        pawn_false.instance_variable_set(:@position, [6, 5])
        expect(pawn_false.first_move?).to be false
      end
    end
  end

  describe '#left_diagonal' do
    context 'when a white pawn is at square d2' do
      subject(:pawn_d2) { described_class.new([3, 1], :white) }

      it 'returns square c3' do
        result = [2, 2]
        expect(pawn_d2.left_diagonal).to eq(result)
      end
    end

    context 'when a white pawn is at square a2' do
      subject(:pawn_a2) { described_class.new([0, 1], :white) }

      it 'returns nil' do
        expect(pawn_a2.left_diagonal).to be nil
      end
    end

    context 'when a black pawn is at square f7' do
      subject(:pawn_f7) { described_class.new([5, 6], :black) }

      it 'returns [6, 5]' do
        result = [6, 5]
        expect(pawn_f7.left_diagonal).to eq(result)
      end
    end

    context 'when a black pawn is at square h7' do
      subject(:pawn_h7) { described_class.new([7, 6], :black) }

      it 'returns nil' do
        expect(pawn_h7.left_diagonal).to be nil
      end
    end
  end

  describe '#right_diagonal' do
    context 'when a black pawn is at square e7' do
      subject(:pawn_e7) { described_class.new([4, 6], :black) }

      it 'returns [3, 5' do
        result = [3, 5]
        expect(pawn_e7.right_diagonal).to eq(result)
      end
    end

    context 'when a white pawn is at h2' do
      subject(:pawn_h2) { described_class.new([7, 1], :white) }

      it 'returns nil' do
        expect(pawn_h2.right_diagonal).to be nil
      end
    end
  end
end
