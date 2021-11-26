require 'yaml'

module GameSerializer
  def save_game
    Dir.mkdir 'game_archive' unless Dir.exist? 'game_archive'
    filename = "game_#{count_files}.yaml"
    File.open("game_archive/#{filename}", 'w') { |file| file.write(save_game_to_yaml)}
    puts game_saved_dialogue
  end

  def save_game_to_yaml
    YAML.dump(
      'player1' => @player1,
      'player2' => @player2,
      'board' => @board,
      'current_player' => @current_player
    )
  end

  def count_files
    dir = 'game_archive'
    game_count = Dir.entries(dir).count
    game_count - 1
  rescue Errno::ENOENT
    1
  end

  def load_game
    print_existing_filenames
    load_file_contents
  end

  def load_file_contents
    filename = solicit_user_selection
    contents = YAML.safe_load(File.read("game_archive/#{filename}"))
    @player1 = contents['player1']
    @player2 = contents['player2']
    @board = contents['board']
    @current_player = contents['current_player']
  end

  def print_existing_filenames
    Dir.entries('game_archive').each do |filename|
      puts filename
    end
  rescue Errno::ENOENT
    puts 'There are no saved files'
  end

  def solicit_user_selection
    puts load_game_dialogue

    loop do
      valid_inputs = Dir.entries('game_archive')
      user_input = gets.chomp
      return user_input if valid_inputs.include?(user_input)

      puts 'Invalid input. Please enter a file name: '
    end
  end

  def load_game_dialogue
    'Please enter the name of the game you would like to load: '
  end

  def game_saved_dialogue
    'Game saved'
  end
end
