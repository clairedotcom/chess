module Dialogue
  def illegal_move
    'Illegal move for that piece. Please try again.'
  end
    
  def invalid_input
    'Invalid input. Please enter the square number and letter (e.g. f5): '
  end

  def intro_dialogue
    puts 'Welcome to chess!'
    puts 'To save the state of your game, please enter "save" at any time.'
  end  
end
