require_relative '../lib/game'

describe Game do
  subject(:test_game) { described_class.new }

  describe '#solicit_start_square' do
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
        error_message = test_game.invalid_input_message
        expect(test_game).to receive(:puts).with(error_message).once
        test_game.solicit_start_square
      end
    end
  end

  describe '#ocupied_by_any_piece?' do
    context 'when given an unocupied square a4' do
      it 'returns false' do
        square = [0, 3]
        expect(test_game.occupied_by_any_piece?(square)).to be false
      end
    end

    context 'when given a square occupied by black e8' do
      it 'returns true' do
        square = [4, 7]
        expect(test_game.occupied_by_any_piece?(square)).to be true
      end
    end

    context 'when given a square occupied by white f1' do
      it 'returns true' do
        square = [6, 0]
        expect(test_game.occupied_by_any_piece?(square)).to be true
      end
    end
  end

  describe '#occupied_by_same_color?' do
    context 'when @current_player is white and the square has a white piece' do
      it 'returns true' do
        square = [0, 0]
        expect(test_game.occupied_by_same_color?(square)).to be true
      end
    end

    context 'when @current_player is white and the square has a black piece' do
      it 'returns false' do
        square = [7, 7]
        expect(test_game.occupied_by_same_color?(square)).to be false
      end
    end
  end

  describe '#save_game' do
    context 'when game_archive directory does not exist' do
      before do
        allow(Dir).to receive(:exist?).and_return(false)
        allow(Dir).to receive(:mkdir)
        allow(File).to receive(:open)
      end

      it 'checks if the directory exists' do
        expect(Dir).to receive(:exist?).with('game_archive').once
        test_game.save_game
      end

      it 'creates a new directory if directory does not exist' do
        expect(Dir).to receive(:mkdir).once
        test_game.save_game
      end

      it 'creates a new file' do
        expect(File).to receive(:open).once
        test_game.save_game
      end
    end
  end

  context 'when the directory exists' do
    before do
      allow(Dir).to receive(:exist?).and_return(true)
      allow(File).to receive(:open)
    end

    it 'checks if the directory exists' do
      expect(Dir).to receive(:exist?).with('game_archive').once
      test_game.save_game
    end

    it 'does not create a new directory' do
      expect(Dir).not_to receive(:mkdir)
      test_game.save_game
    end

    it 'creates a new file' do
      expect(File).to receive(:open).once
      test_game.save_game
    end
  end

  describe '#count_files' do
    context 'when the directory does not exist' do
      it 'returns zero' do
        expect(test_game.count_files).to eq(0)
      end
    end

    context 'when the directory exists with 2 files' do
      before do
        files = %w[game_1 game_2]
        allow(Dir).to receive(:entries).and_return(files)
      end

      it 'returns 3' do
        number = 3
        expect(test_game.count_files).to eq(number)
      end
    end
  end

  describe '#print_existing_filenames' do
    context 'when there is one file in game_arhive' do
      before do
        file = %w[game_1]
        allow(Dir).to receive(:entries).and_return(file)
      end

      it 'returns the file names' do
        file = 'game_1'
        expect(test_game).to receive(:puts).with(file).once
        test_game.print_existing_filenames
      end
    end

    context 'when there are 3 files in game_archive' do
      before do
        files = %w[game_1 game_2 game_3]
        allow(Dir).to receive(:entries).and_return(files)
      end

      it 'returns the file names' do
        name1 = 'game_1'
        name2 = 'game_2'
        name3 = 'game_3'
        expect(test_game).to receive(:puts).with(name1)
        expect(test_game).to receive(:puts).with(name2)
        expect(test_game).to receive(:puts).with(name3)
        test_game.print_existing_filenames
      end
    end
  end
end
