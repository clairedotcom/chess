require_relative '../lib/rook'

describe Rook do
  describe '#line1' do
    context 'when initialized at square a1' do
      subject(:rook_a1) { described_class.new([0, 0]) }

      it 'returns the correct array' do
        result = [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]]
        expect(rook_a1.line1).to eq(result)
      end
    end
  end

  describe '#line2' do
    context 'when initialized at square a1' do
      subject(:rook_a1) { described_class.new([0, 0]) }

      it 'returns the correct array' do
        result = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]]
        expect(rook_a1.line2).to eq(result)
      end
    end
  end

  describe '#line3' do
    context 'when initialized at square a1' do
      subject(:rook_a1) { described_class.new([0, 0]) }

      it 'returns an empty array' do
        result = []
        expect(rook_a1.line3).to eq(result)
      end
    end
  end

  describe '#line4' do
    context 'when initialized at square a1' do
      subject(:rook_a1) { described_class.new([0, 0]) }

      it 'returns an empty array' do
        result = []
        expect(rook_a1.line4).to eq(result)
      end
    end
  end
end
