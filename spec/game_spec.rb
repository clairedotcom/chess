require_relative '../lib/game'

describe Game do
  subject(:test_game) { described_class.new }

  describe '#select_game_mode' do
    context 'when the user inputs 2' do
      before do
        user_input = '2'
        allow(test_game).to receive(:gets).and_return(user_input)
      end

      it 'calls #load_game' do
        expect(test_game).to respond_to(:load_game)
      end
    end
  end

  describe '#validate_game_mode_input' do
    context 'when the user inputs 1 or 2' do
      before do
        user_input = '1'
        allow(test_game).to receive(:gets).and_return(user_input)
      end

      it 'returns 1' do
        result = 1
        expect(test_game.validate_game_mode_input).to eq(result)
      end
    end

    context 'when the user inputs something other than 1 or 2' do
      before do
        invalid_input = 'asdf'
        valid_input = '2'
        allow(test_game).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'prints an error message' do
        error_message = test_game.invalid_mode_input_message
        expect($stdout).to receive(:puts).with(error_message).once
        test_game.validate_game_mode_input
      end
    end
  end

  describe '#turn' do
  end

  describe '#review_move' do
  end

  describe '#solicit_move' do
  end

  describe '#soliit_start_square' do
  end

  describe '#check?' do
  end

  describe '#find_all_moves' do
  end

  describe '#game_over?' do
  end

  describe '#capture' do
  end

  describe '#update_board' do
    context 'when passed a move' do
      it 'sends a signal to the player to update the board' do
        start = [0, 1]
        finish = [0, 3]
        expect(test_game.board).to receive(:update_board).with(start, finish)
        test_game.update_board(start, finish)
      end
    end
  end

  describe '#switch_player' do
    context 'when called on a game in its initial state' do
      before do
        test_game.switch_player
      end

      it 'changes current_player to player2' do
        player2 = test_game.player2
        expect(test_game.current_player).to eq(player2)
      end
    end
  end

  describe '#opposite_player' do
    context 'when initialized' do
      it 'returns the black player' do
        player2 = test_game.player2
        expect(test_game.opposite_player).to eq(player2)
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

  describe '#occupied_by_opposite_color?' do
    context 'when white is @current_player and the square has a black piece' do
      it 'returns true' do
        square = [7, 7]
        expect(test_game.occupied_by_opposite_color?(square)).to be true
      end
    end

    context 'when white is @current_player and the square has a white piece' do
      it 'returns false' do
        square = [6, 1]
        expect(test_game.occupied_by_opposite_color?(square)).to be false
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
        allow(test_game).to receive(:puts)
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
        expect(File).to receive(:open)
        test_game.save_game
      end
    end

    context 'when the directory exists' do
      before do
        allow(Dir).to receive(:exist?).and_return(true)
        allow(File).to receive(:open)
        allow(test_game).to receive(:puts)
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
  end

  describe '#count_files' do
    context 'when the directory does not exist' do
      before do
        allow(Dir).to receive(:entries).and_raise(Errno::ENOENT)
      end

      it 'returns one' do
        expect(test_game.count_files).to eq(1)
      end
    end

    context 'when the directory exists with 2 files' do
      before do
        files = %w[. .. game_1 game_2]
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
