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
end
