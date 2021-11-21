require_relative '../lib/game'

describe Game do
    describe '#solicit_start_square' do
      subject(:test_game) { described_class.new }
      
      context 'when the user inputs a2' do
          before do
            allow(test_game).to receive(:gets).and_return('a2')
          end

          it 'returns [0, 1]' do
            result = [0, 1]
            expect(test_game.solicit_start_square).to eq(result)
          end
      end

      context 'when the user inputs an invalid input' do
        before do
          letters = 'abcd'
          valid_input = 'e2'
          allow(test_game).to receive(:gets).and_return(letters, valid_input) 
        end

        it 'prints an error message' do
          error_message = test_game.invalid_input
          expect(test_game).to receive(:puts).with(error_message).once
          test_game.solicit_start_square
        end
      end
    end
end