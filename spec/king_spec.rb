require_relative '../lib/king'

describe King do
  subject(:test_king) { described_class.new([4, 0], :white) }

  describe '#set_icon' do
    context 'when initialized' do
      it 'returns the correct icon string' do
        expected_icon = "\e[37m\u265A \e[0m"
        expect(test_king.icon).to eq(expected_icon)
      end
    end
  end
end
