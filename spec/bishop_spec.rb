require_relative '../lib/bishop'

describe Bishop do
  describe '#moves' do
    context 'when the bishop is at [4,4]' do
      subject(:test_bishop) { described_class.new([4, 4]) }

      it 'generates [5,5] as a move' do
        all_moves = test_bishop.moves
        expect(all_moves).to include([5, 5])
      end

      it 'does not generate [8,8] as a move' do
        all_moves = test_bishop.moves
        expect(all_moves).not_to include([8, 8])
      end
    end
  end
end
