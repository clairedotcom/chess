require_relative '../lib/rook'

describe Rook do
  subject(:test_rook) { described_class.new([0, 0], :white) }

  describe '#set_icon' do
    context 'when initialized' do
      it 'returns the correct icon string' do
        icon_string = "\e[37m\u265C \e[0m"
        expect(test_rook.icon).to eq(icon_string)
      end
    end
  end

  describe '#line1' do
    context 'when initialized at square a1' do
      it 'returns the correct array' do
        result = [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]]
        expect(test_rook.line1).to eq(result)
      end
    end
  end

  describe '#line2' do
    context 'when initialized at square a1' do
      it 'returns the correct array' do
        result = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]]
        expect(test_rook.line2).to eq(result)
      end
    end
  end

  describe '#line3' do
    context 'when initialized at square a1' do
      it 'returns an empty array' do
        result = []
        expect(test_rook.line3).to eq(result)
      end
    end
  end

  describe '#line4' do
    context 'when initialized at square a1' do
      it 'returns an empty array' do
        result = []
        expect(test_rook.line4).to eq(result)
      end
    end
  end
end
