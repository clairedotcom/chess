require_relative '../lib/bishop'

describe Bishop do
  describe '#line1' do
    subject(:bishop_c1) { described_class.new([2, 0]) }

    context 'when the bishop is at an initial position of c1' do
      it 'returns the correct array of moves' do
        result = [[3, 1], [4, 2], [5, 3], [6, 4], [7, 5]]
        expect(bishop_c1.line1).to eq(result)
      end
    end
  end

  describe '#line2' do
    subject(:bishop_c1) { described_class.new([2, 0]) }

    context 'when the bishop is at c1' do
      it 'returns the correct array of moves' do
        result = [[1, 1], [0, 2]]
        expect(bishop_c1.line2).to eq(result)
      end
    end
  end

  describe '#line3' do
    subject(:bishop_c1) { described_class.new([2, 0]) }

    context 'when the bishop is at c1' do
      it 'returns the correct array of moves' do
        result = []
        expect(bishop_c1.line3).to eq(result)
      end
    end
  end

  describe '#line4' do
    subject(:bishop_c1) { described_class.new([2, 0]) }

    context 'when the bishop is at c1' do
      it 'returns the correct array of moves' do
        result = []
        expect(bishop_c1.line4).to eq(result)
      end
    end
  end
end
