require_relative '../lib/bishop'

describe Bishop do
  subject(:test_bishop) { described_class.new([2, 0], :white) }

  describe '#set_icon' do
    context 'when a white bishop is initialized' do
      it 'returns the correct icon string' do
        icon_string = "\e[37m\u265D \e[0m"
        expect(test_bishop.icon).to eq(icon_string)
      end
    end
  end

  describe '#line1' do
    context 'when the bishop is at an initial position of c1' do
      it 'returns the correct array of moves' do
        result = [[3, 1], [4, 2], [5, 3], [6, 4], [7, 5]]
        expect(test_bishop.line1).to eq(result)
      end
    end
  end

  describe '#line2' do
    context 'when the bishop is at c1' do
      it 'returns the correct array of moves' do
        result = [[1, 1], [0, 2]]
        expect(test_bishop.line2).to eq(result)
      end
    end
  end

  describe '#line3' do
    context 'when the bishop is at c1' do
      it 'returns the correct array of moves' do
        result = []
        expect(test_bishop.line3).to eq(result)
      end
    end
  end

  describe '#line4' do
    context 'when the bishop is at c1' do
      it 'returns the correct array of moves' do
        result = []
        expect(test_bishop.line4).to eq(result)
      end
    end
  end
end
