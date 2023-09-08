require_relative '../lib/move_referee.rb'
require_relative '../lib/board.rb'
require_relative '../lib/game.rb'
require_relative '../lib/move.rb'

describe MoveReferee do
  describe '#get_all_possible_moves' do
    context 'when there are two kings and one black knight one the board' do
      it 'returns the correct array of pieces' do
        board = Array.new(8) { Array.new(8, nil) }
        whiteking = King.new([1, 4], :white)
        blackking = King.new([4, 7], :black)
        blackknight = Knight.new([5, 4], :black)
        board[1][4] = whiteking
        board[4][7] = blackking
        board[5][4] = blackknight
        game_state = board.flatten.delete_if { |element| element.nil? }
        opposing_moves = [[3, 7], [3, 6], [4, 6], [5, 6], [5, 7],
                          [3, 5], [4, 6], [6, 6], [7, 5], [7, 3], [6, 2], [4, 2], [3, 3]]
        referee = MoveReferee.new(game_state, whiteking, nil)
        king_location = whiteking.position
        expect(referee.possible_opposing_moves).to match_array(opposing_moves)
        expect(king_location).to eq(referee.get_king_location)
      end
    end
  end


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

    context 'when a white king side castle move is selected' do
      it 'move.valid is set to true' do
        game = Game.new
        board = game.board
        board.delete_piece([5, 0])
        board.delete_piece([6, 0])
        game_state = game.format_board_state
        king = board.get_square(4, 0)
        rook = board.get_square(7, 0)
        castlemove = Move.new([4, 0], [6, 0])
        referee = MoveReferee.new(game_state, king, castlemove)
        referee.move_valid
        expect(castlemove.valid).to eq true
        expect(king.position).to eq [6, 0]
        expect(rook.position).to eq [5, 0]
      end
    end

    context 'when a white king side castle move is selected and the rook has moved' do
      it 'move.valid remains false' do
        game = Game.new
        board = game.board
        board.delete_piece([5, 0])
        board.delete_piece([6, 0])
        game_state = game.format_board_state
        king = board.get_square(4, 0)
        rook = board.get_square(7, 0)
        rook.move_count = 1
        castlemove = Move.new([4, 0], [6, 0])
        referee = MoveReferee.new(game_state, king, castlemove)
        referee.move_valid
        expect(castlemove.valid).to eq false
      end
    end

    context 'when a white king side castle move is selected and there is no rook' do
      it 'move.valid remains false' do
        game = Game.new
        board = game.board
        board.delete_piece([5, 0])
        board.delete_piece([6, 0])
        board.delete_piece([7, 0])
        game_state = game.format_board_state
        king = board.get_square(4, 0)
        castlemove = Move.new([4, 0], [6, 0])
        referee = MoveReferee.new(game_state, king, castlemove)
        referee.move_valid
        expect(castlemove.valid).to eq false
      end
    end

    context 'when a black king side castle move is selected' do
      it 'move.valid is set to true' do
        game = Game.new
        board = game.board
        board.delete_piece([5, 7])
        board.delete_piece([6, 7])
        game_state = game.format_board_state
        king = board.get_square(4, 7)
        rook = board.get_square(7, 7)
        castlemove = Move.new([4, 7], [6, 7])
        referee = MoveReferee.new(game_state, king, castlemove)
        referee.move_valid
        expect(castlemove.valid).to eq true
        expect(king.position).to eq [6, 7]
        expect(rook.position).to eq [5, 7]
      end
    end

    context 'when a black king side castle move is selected and the rook has moved' do
      it 'move.valid is set to true' do
        game = Game.new
        board = game.board
        board.delete_piece([5, 7])
        board.delete_piece([6, 7])
        game_state = game.format_board_state
        king = board.get_square(4, 7)
        rook = board.get_square(7, 7)
        rook.move_count = 1
        castlemove = Move.new([4, 7], [6, 7])
        referee = MoveReferee.new(game_state, king, castlemove)
        referee.move_valid
        expect(castlemove.valid).to eq false
      end
    end

    context 'when a white queen side castle move is selected' do
      it 'move.valid is set to true' do
        game = Game.new
        board = game.board
        board.delete_piece([1, 0])
        board.delete_piece([2, 0])
        board.delete_piece([3, 0])
        game_state = game.format_board_state
        king = board.get_square(4, 0)
        rook = board.get_square(0, 0)
        castlemove = Move.new([4, 0], [2, 0])
        referee = MoveReferee.new(game_state, king, castlemove)
        referee.move_valid
        expect(castlemove.valid).to eq true
        expect(king.position).to eq [2, 0]
        expect(rook.position).to eq [3, 0]
      end
    end

    context 'when a white queen side castle move is selected and the rook has moved' do
      it 'move.valid remains false' do
        game = Game.new
        board = game.board
        board.delete_piece([1, 0])
        board.delete_piece([2, 0])
        board.delete_piece([3, 0])
        game_state = game.format_board_state
        king = board.get_square(4, 0)
        rook = board.get_square(0, 0)
        rook.move_count = 1
        castlemove = Move.new([4, 0], [2, 0])
        referee = MoveReferee.new(game_state, king, castlemove)
        referee.move_valid
        expect(castlemove.valid).to eq false
      end
    end

    context 'when a black queen side castle move is selected' do
      it 'move.valid is set to true' do
        game = Game.new
        board = game.board
        board.delete_piece([1, 7])
        board.delete_piece([2, 7])
        board.delete_piece([3, 7])
        game_state = game.format_board_state
        king = board.get_square(4, 7)
        rook = board.get_square(0, 7)
        castlemove = Move.new([4, 7], [2, 7])
        referee = MoveReferee.new(game_state, king, castlemove)
        referee.move_valid
        expect(castlemove.valid).to eq true
        expect(king.position).to eq [2, 7]
        expect(rook.position).to eq [3, 7]
      end
    end

    context 'when a black queen side castle move is selected and the rook has moved' do
      it 'move.valid remains false' do
        game = Game.new
        board = game.board
        board.delete_piece([1, 7])
        board.delete_piece([2, 7])
        board.delete_piece([3, 7])
        game_state = game.format_board_state
        king = board.get_square(4, 7)
        rook = board.get_square(0, 7)
        rook.move_count = 1
        castlemove = Move.new([4, 7], [2, 7])
        referee = MoveReferee.new(game_state, king, castlemove)
        referee.move_valid
        expect(castlemove.valid).to eq false
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

    context 'when a white pawn performs a legal en passant move' do
      it 'move.valid is set to true' do
        game = Game.new
        board = game.board
        game_state = game.format_board_state
        # Move pawn e2 e4
        whitepawn = board.get_square(4, 1)
        whitepawnmove1 = Move.new([4, 1], [4, 3])
        firstreferee = MoveReferee.new(game_state, whitepawn, whitepawnmove1)
        firstreferee.move_valid
        board.update_board(1,2)
        # Move pawn f7 f5
        blackpawn = board.get_square(5, 6)
        blackpawnmove1 = Move.new([5, 6], [5, 4])
        secondreferee = MoveReferee.new(game_state, blackpawn, blackpawnmove1)
        secondreferee.move_valid
        board.update_board(1,2)
        # Move pawn e4 e5
        whitepawnmove2 = Move.new([4, 3], [4, 4])
        thirdreferee = MoveReferee.new(game_state, whitepawn, whitepawnmove2)
        thirdreferee.move_valid
        board.update_board(1,2)
        # Move pawn d7 d5
        blackpawn2 = board.get_square(3, 6)
        blackpawnmove2 = Move.new([3, 6], [3, 4])
        fourthreferee = MoveReferee.new(game_state, blackpawn2, blackpawnmove2)
        fourthreferee.move_valid
        board.update_board(1,2)
        # Finally, make en passant move!
        enpassantmove = Move.new([4, 4], [3, 5])
        enpassantreferee = MoveReferee.new(game_state, whitepawn, enpassantmove)
        enpassantreferee.move_valid
        board.update_board(1,2)
        expect(enpassantmove.valid).to eq true
      end
    end

    context 'when a white pawn performs an illegal en passant move on a pawn that made two one square moves' do
      it 'move.valid remains false' do
        game = Game.new
        board = game.board
        game_state = game.format_board_state
        # Move pawn e2 e4
        whitepawn = board.get_square(4, 1)
        whitepawnmove1 = Move.new([4, 1], [4, 3])
        firstreferee = MoveReferee.new(game_state, whitepawn, whitepawnmove1)
        firstreferee.move_valid
        board.update_board(1,2)
        # Move pawn d7 d6
        blackpawn = board.get_square(3, 6)
        blackpawnmove1 = Move.new([3, 6], [3, 5])
        secondreferee = MoveReferee.new(game_state, blackpawn, blackpawnmove1)
        secondreferee.move_valid
        board.update_board(1,2)
        # Move pawn e4 e5
        whitepawnmove2 = Move.new([4, 3], [4, 4])
        thirdreferee = MoveReferee.new(game_state, whitepawn, whitepawnmove2)
        thirdreferee.move_valid
        board.update_board(1,2)
        # Move pawn d6 d5
        blackpawn2 = board.get_square(3, 5)
        blackpawnmove2 = Move.new([3, 5], [3, 4])
        fourthreferee = MoveReferee.new(game_state, blackpawn2, blackpawnmove2)
        fourthreferee.move_valid
        board.update_board(1,2)
        # Finally, make en passant move!
        enpassantmove = Move.new([4, 4], [3, 5])
        enpassantreferee = MoveReferee.new(game_state, whitepawn, enpassantmove)
        enpassantreferee.move_valid
        board.update_board(1,2)
        expect(enpassantmove.valid).to eq false
      end
    end

    context 'when a black pawn performs a legal en passant move' do
      it 'move.valid is set to true' do
        game = Game.new
        board = game.board
        game_state = game.format_board_state
        # Move pawn g2 g4
        whitepawn2 = board.get_square(6, 1)
        whitepawnmove3 = Move.new([6, 1], [6, 3])
        fifthreferee = MoveReferee.new(game_state, whitepawn2, whitepawnmove3)
        fifthreferee.move_valid
        board.update_board(1,2)
        # Move pawn f7 f5
        blackpawn = board.get_square(5, 6)
        blackpawnmove1 = Move.new([5, 6], [5, 4])
        secondreferee = MoveReferee.new(game_state, blackpawn, blackpawnmove1)
        secondreferee.move_valid
        board.update_board(1,2)
        # Move pawn e2 e4
        whitepawn = board.get_square(4, 1)
        whitepawnmove1 = Move.new([4, 1], [4, 3])
        firstreferee = MoveReferee.new(game_state, whitepawn, whitepawnmove1)
        firstreferee.move_valid
        board.update_board(1,2)
        # Move pawn f5 f4
        blackpawnmove2 = Move.new([5, 4], [5, 3])
        fourthreferee = MoveReferee.new(game_state, blackpawn, blackpawnmove2)
        fourthreferee.move_valid
        board.update_board(1,2)
        # Move pawn e4 e5
        whitepawnmove2 = Move.new([4, 3], [4, 4])
        thirdreferee = MoveReferee.new(game_state, whitepawn, whitepawnmove2)
        thirdreferee.move_valid
        board.update_board(1,2)
        # Make en passant move
        enpassantmove = Move.new([5, 3], [6, 2])
        enpassantreferee = MoveReferee.new(game_state, blackpawn, enpassantmove)
        enpassantreferee.move_valid
        board.update_board(1, 2)
        expect(enpassantmove.valid).to eq false
      end
    end

    context 'when a black pawn performs an illegal en passant move on a pawn that did not move last turn' do
      it 'move.valid is set to true' do
        game = Game.new
        board = game.board
        game_state = game.format_board_state
        # Move pawn e2 e4
        whitepawn = board.get_square(4, 1)
        whitepawnmove1 = Move.new([4, 1], [4, 3])
        firstreferee = MoveReferee.new(game_state, whitepawn, whitepawnmove1)
        firstreferee.move_valid
        board.update_board(1,2)
        # Move pawn f7 f5
        blackpawn = board.get_square(5, 6)
        blackpawnmove1 = Move.new([5, 6], [5, 4])
        secondreferee = MoveReferee.new(game_state, blackpawn, blackpawnmove1)
        secondreferee.move_valid
        board.update_board(1,2)
        # Move pawn e4 e5
        whitepawnmove2 = Move.new([4, 3], [4, 4])
        thirdreferee = MoveReferee.new(game_state, whitepawn, whitepawnmove2)
        thirdreferee.move_valid
        board.update_board(1,2)
        # Move pawn f5 f4
        #blackpawn2 = board.get_square(5, 4)
        blackpawnmove2 = Move.new([5, 4], [5, 3])
        fourthreferee = MoveReferee.new(game_state, blackpawn, blackpawnmove2)
        fourthreferee.move_valid
        board.update_board(1,2)
        # Move pawn g2 g4
        whitepawn2 = board.get_square(6, 1)
        whitepawnmove3 = Move.new([6, 1], [6, 3])
        fifthreferee = MoveReferee.new(game_state, whitepawn2, whitepawnmove3)
        fifthreferee.move_valid
        board.update_board(1,2)
        # Make en passant move
        enpassantmove = Move.new([5, 3], [6, 2])
        enpassantreferee = MoveReferee.new(game_state, blackpawn, enpassantmove)
        enpassantreferee.move_valid
        board.update_board(1, 2)
        expect(enpassantmove.valid).to eq true
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
        game = Game.new
        board = game.board
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
    #move is illegal because there's a pawn in h2
      it 'move.valid remains false' do
        game = Game.new
        board = game.board
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
          game = Game.new
          board = game.board
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
        pawn = board.get_square(7,1)
        pawn.position = [7,3]
        game_state = board.state.flatten.delete_if { |element| element.nil? }
        piece = board.get_square(7, 0)
        whiterookmove = Move.new([7, 0], [7, 2])
        referee = MoveReferee.new(game_state, piece, whiterookmove)
        referee.move_valid
        expect(whiterookmove.valid).to eq true
      end
    end
  end

  describe 'get_king_location' do
    context 'when a white king is in its initial position' do
      it 'returns [4,0]' do
        game = Game.new
        board = game.board
        game_state = game.format_board_state
        piece = board.get_square(7, 0)
        whiterookmove = Move.new([7,0], [5,2])
        referee = MoveReferee.new(game_state, piece, whiterookmove)
        expect(referee.get_king_location).to eq [4,0]
      end
    end

    context 'when a white king has moved to [4, 2]' do
      it 'returns [4, 2]' do
        game = Game.new
        board = game.board
        piece = board.get_square(4, 0)
        piece.position = [4,2]
        game_state = game.format_board_state
        whiterookmove = Move.new([7,0], [5,2])
        referee = MoveReferee.new(game_state, piece, whiterookmove)
        expect(referee.get_king_location).to eq [4,2]
      end
    end

    context 'when a black king is in its initial position' do
      it 'returns [4, 7]' do
        game = Game.new
        board = game.board
        game_state = game.format_board_state
        piece = board.get_square(7, 7)
        rookmove = Move.new([7,7], [7,5])
        referee = MoveReferee.new(game_state, piece, rookmove)
        expect(referee.get_king_location).to eq [4,7]
      end
    end

    context 'when a black king has moved to [4, 5]' do
      it 'returns [4, 5]' do
        game = Game.new
        board = game.board
        piece = board.get_square(4, 7)
        piece.position = [4,5]
        game_state = game.format_board_state
        rookmove = Move.new([7,7], [7,5])
        referee = MoveReferee.new(game_state, piece, rookmove)
        expect(referee.get_king_location).to eq [4,5]
      end
    end
  end
end