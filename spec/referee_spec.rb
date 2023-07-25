require_relative '../lib/move_referee.rb'
require_relative '../lib/board.rb'
require_relative '../lib/game.rb'
require_relative '../lib/move.rb'

describe MoveReferee do
  describe 'check_bishop' do
    context 'when a bishop is moved illegally with pieces in the way' do
      it 'move.valid remains false' do
        board = Board.new
        game = Game.new
        game_state = game.format_board_state
        piece = board.get_square(5, 0)
        bishopmove = Move.new([5,0], [7,2])
        referee = MoveReferee.new(game_state, piece, bishopmove)
        referee.move_valid
        expect(bishopmove.valid).to eq false
      end
    end

    context 'when a bishop is moved illegally in a straight line' do
      it 'move.valid remains false' do
        board = Board.new
        game = Game.new
        game_state = game.format_board_state
        pawn = board.get_square(5, 1)
        pawnmove = Move.new([5,1], [5,3])
        pawnreferee = MoveReferee.new(game_state, pawn, pawnmove)
        board.update_board(pawnmove.origin, pawnmove.dest)
        bishop = board.get_square(5, 0)
        bishopmove = Move.new([5,0], [5,2])
        referee = MoveReferee.new(game_state, bishop, bishopmove)
        referee.move_valid
        expect(bishopmove.valid).to eq false
      end
    end

    context 'when a bishop is moved legally in a diagonal line' do
      it 'move.valid is set to true' do
        board = Board.new
        game = Game.new
        game_state = game.format_board_state
        pawn = board.get_square(6, 1)
        pawnmove = Move.new([6,1], [6,3])
        pawnreferee = MoveReferee.new(game_state, pawn, pawnmove)
        pawnreferee.move_valid
        board.update_board(pawnmove.origin, pawnmove.dest)
        game_state = board.state.flatten.delete_if { |element| element.nil? }
        bishop = board.get_square(5, 0)
        bishopmove = Move.new([5,0], [7,2])
        referee = MoveReferee.new(game_state, bishop, bishopmove)
        referee.move_valid
        expect(bishopmove.valid).to eq true
      end
    end
  end

  describe 'check_king' do
    context 'when a king is moved illegally with its own piece in the way' do
      it 'move.valid remains false' do
        board = Board.new
        game = Game.new
        game_state = game.format_board_state
        piece = board.get_square(4, 0)
        kingmove = Move.new([4,0], [5,0])
        referee = MoveReferee.new(game_state, piece, kingmove)
        referee.move_valid
        expect(kingmove.valid).to eq false
      end
    end

    context 'when a king is moved legally' do
      it 'move.valid is set to true' do
        board = Board.new
        game = Game.new
        game_state = game.format_board_state
        pawn = board.get_square(5, 1)
        pawnmove = Move.new([5,1], [5,3])
        pawnreferee = MoveReferee.new(game_state, pawn, pawnmove)
        pawnreferee.move_valid
        board.update_board(pawnmove.origin, pawnmove.dest)
        game_state = board.state.flatten.delete_if { |element| element.nil? }
        piece = board.get_square(4, 0)
        kingmove = Move.new([4,0], [5,0])
        referee = MoveReferee.new(game_state, piece, kingmove)
        referee.move_valid
        expect(kingmove.valid).to eq false
      end
    end
  end


  describe 'check_knight' do
    context 'when a knight is moved illegally in a straight line' do
      it 'move.valid remains false' do
        board = Board.new
        game = Game.new
        game_state = game.format_board_state
        piece = board.get_square(6, 0)
        knightmove = Move.new([6,0], [6,3])
        referee = MoveReferee.new(game_state, piece, knightmove)
        referee.move_valid
        expect(knightmove.valid).to eq false
      end
    end

    context 'when a knight is moved legally' do
      it 'move.valid is set to true' do
        board = Board.new
        game = Game.new
        game_state = game.format_board_state
        piece = board.get_square(6, 0)
        knightmove = Move.new([6,0], [7,2])
        referee = MoveReferee.new(game_state, piece, knightmove)
        referee.move_valid
        expect(knightmove.valid).to eq true
      end
    end
  end

  describe 'check_pawn' do
    context 'when a pawn is moved illegally in a diagonal direction' do
      it 'move.valid remains false' do
        board = Board.new
        game = Game.new
        game_state = game.format_board_state
        piece = board.get_square(5, 1)
        pawnmove = Move.new([5,1], [4,2])
        referee = MoveReferee.new(game_state, piece, pawnmove)
        referee.move_valid
        expect(pawnmove.valid).to eq false
      end
    end

    context 'when a pawn is moved legally in a forward direction by one square' do
      it 'move.valid is set to true' do
        board = Board.new
        game = Game.new
        game_state = game.format_board_state
        piece = board.get_square(5, 1)
        pawnmove = Move.new([5,1], [5,2])
        referee = MoveReferee.new(game_state, piece, pawnmove)
        referee.move_valid
        expect(pawnmove.valid).to eq true
      end
    end

    context 'when a pawn is moved legally in a forward direction by two squares' do
      it 'move.valid is set to true' do
        board = Board.new
        game = Game.new
        game_state = game.format_board_state
        piece = board.get_square(5, 1)
        pawnmove = Move.new([5,1], [5,3])
        referee = MoveReferee.new(game_state, piece, pawnmove)
        referee.move_valid
        expect(pawnmove.valid).to eq true
      end
    end

    context 'when a pawn is moved illegally two squares after already moving' do
      it 'move.valid remains false' do
        board = Board.new
        game = Game.new
        game_state = game.format_board_state
        piece = board.get_square(5, 1)
        firstpawnmove = Move.new([5,1], [5,3])
        secondpawnmove = Move.new([5,3], [5,5])
        firstreferee = MoveReferee.new(game_state, piece, firstpawnmove)
        firstreferee.move_valid
        secondreferee = MoveReferee.new(game_state, piece, secondpawnmove)
        secondreferee.move_valid
        expect(firstpawnmove.valid).to eq true
        board.update_board(firstpawnmove.origin, firstpawnmove.dest)
        expect(secondpawnmove.valid).to eq false
      end
    end
  end
  
  describe 'check_queen' do
    context 'when a queen is moved illegally with a piece in the way' do
      it 'move.valid remains false' do
        board = Board.new
        game = Game.new
        game_state = game.format_board_state
        piece = board.get_square(3, 0)
        queenmove = Move.new([3,0], [3,5])
        referee = MoveReferee.new(game_state, piece, queenmove)
        referee.move_valid
        expect(queenmove.valid).to eq false
      end
    end

    context 'when a queen is moved legally in a diagonal direction' do
      it 'move.valid is set to true' do
        board = Board.new
        game = Game.new
        game_state = game.format_board_state
        pawn = board.get_square(2, 1)
        pawnmove = Move.new([2,1], [2,3])
        pawnreferee = MoveReferee.new(game_state, pawn, pawnmove)
        pawnreferee.move_valid
        board.update_board(pawnmove.origin, pawnmove.dest)
        game_state = board.state.flatten.delete_if { |element| element.nil? }
        queen = board.get_square(3, 0)
        queenmove = Move.new([3,0], [0,3])
        referee = MoveReferee.new(game_state, queen, queenmove)
        referee.move_valid
        expect(queenmove.valid).to eq true
      end
    end
  end

  describe 'check_rook' do
    context 'when a rook is moved illegally from h1 to h3' do
    #move is illegal because there's a pwan in h2
      it 'move.valid remains false' do
        board = Board.new
        game = Game.new
        game_state = game.format_board_state
        piece = board.get_square(7, 0)
        whiterookmove = Move.new([7,0], [7,2])
        referee = MoveReferee.new(game_state, piece, whiterookmove)
        referee.move_valid
        expect(whiterookmove.valid).to eq false
      end
    end

    context 'when a rook is moved illegally from h1 to f3' do
      #move is illegal because rook does not move diagonally
        it 'move.valid remains false' do
          board = Board.new
          game = Game.new
          game_state = game.format_board_state
          piece = board.get_square(7, 0)
          whiterookmove = Move.new([7,0], [5,2])
          referee = MoveReferee.new(game_state, piece, whiterookmove)
          referee.move_valid
          expect(whiterookmove.valid).to eq false
        end
      end

    context 'when a rook is moved legally from h1 to h3' do
      it 'move.valid is set from false to true' do
        board = Board.new
        board.update_board([7, 1], [7, 3])
        board.get_square(7, 3).position = [7, 3]
        game_state = board.state.flatten.delete_if { |element| element.nil? }
        piece = board.get_square(7, 0)
        whiterookmove = Move.new([7, 0], [7, 2])
        referee = MoveReferee.new(game_state, piece, whiterookmove)
        referee.move_valid
        expect(whiterookmove.valid).to eq true
      end
    end
  end
end