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
end
