require_relative '../lib/player'

describe Player do
  describe '#find_king_location' do
    subject(:test_player) { described_class.new(:white) }

    context 'when a white player set is initialized' do
      it 'returns [4, 0]' do
        result = [4, 0]
        expect(test_player.find_king_location).to eq(result)
      end
    end
  end
end
