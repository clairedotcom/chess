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
end
