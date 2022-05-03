require_relative '../lib/pawn'

describe Pawn do
  subject(:test_pawn) { described_class.new([0, 1], :white) }

  describe '#set_icon' do
    context 'when a white pawn is initialized' do
      it 'returns the correct icon string' do
        icon_string = "\e[37m\u265F \e[0m"
        expect(test_pawn.icon).to eq(icon_string)
      end
    end
  end

  describe '#moves' do
    context 'when a pawn is at its initial position' do
      it 'returns a one square and two square move' do
        result = [[0, 3], [0, 2]]
        expect(test_pawn.moves).to eq(result)
      end
    end

    context 'when the pawn has moved' do
      before do
        test_pawn.position = [3, 3]
      end

      it 'returns a one square move' do
        result = [[3, 4]]
        expect(test_pawn.moves).to eq(result)
      end
    end
  end

  describe '#first_move?' do
    context 'when current position equals initial position' do
      it 'returns true' do
        expect(test_pawn.first_move?).to be true
      end
    end

    context 'when the pawn has moved from its initial position' do
      before do
        test_pawn.position = [6, 5]
      end

      it 'returns false' do
        expect(test_pawn.first_move?).to be false
      end
    end
  end

  describe '#left_diagonal' do
    context 'when a white pawn is at square d2' do
      before do
        test_pawn.position = [3, 1]
      end

      it 'returns square c3' do
        result = [2, 2]
        expect(test_pawn.left_diagonal).to eq(result)
      end
    end

    context 'when a white pawn is at square a2' do
      before do
        test_pawn.position = [0, 1]
      end

      it 'returns nil' do
        expect(test_pawn.left_diagonal).to be nil
      end
    end

    context 'when a black pawn is at square f7' do
      before do
        test_pawn.color = :black
        test_pawn.position = [5, 6]
      end

      it 'returns [6, 5]' do
        result = [6, 5]
        expect(test_pawn.left_diagonal).to eq(result)
      end
    end

    context 'when a black pawn is at square h7' do
      before do
        test_pawn.color = :black
        test_pawn.position = [7, 6]
      end

      it 'returns nil' do
        expect(test_pawn.left_diagonal).to be nil
      end
    end
  end

  describe '#right_diagonal' do
    context 'when a black pawn is at square e7' do
      before do
        test_pawn.color = :black
        test_pawn.position = [4, 6]
      end

      it 'returns [3, 5]' do
        result = [3, 5]
        expect(test_pawn.right_diagonal).to eq(result)
      end
    end

    context 'when a black pawn is at square a7' do
      before do
        test_pawn.color = :black
        test_pawn.position = [0, 6]
      end

      it 'returns nil' do
        expect(test_pawn.right_diagonal).to be nil
      end
    end

    context 'when a white pawn is at h2' do
      before do
        test_pawn.position = [7, 1]
      end

      it 'returns nil' do
        expect(test_pawn.right_diagonal).to be nil
      end
    end

    context 'when a white pawn is at d5' do
      before do
        test_pawn.position = [4, 4]
      end

      it 'returns [5, 5]' do
        result = [5, 5]
        expect(test_pawn.right_diagonal).to eq(result)
      end
    end
  end
end
