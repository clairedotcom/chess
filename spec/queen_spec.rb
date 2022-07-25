require_relative '../lib/queen'

describe Queen do
  subject(:test_queen) { described_class.new([4, 0], :white) }

  describe '#set_icon' do
    context 'when initialized' do
      it 'returns the correct icon string' do
        icon_string = "\e[37m\u265B \e[0m"
        expect(test_queen.icon).to eq(icon_string)
      end
    end
  end
end
