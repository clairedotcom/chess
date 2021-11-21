require 'yaml'

module GameSerializer
  def save_game
    Dir.mkdir 'game_archive' unless Dir.exist? 'game_archive'
    filename = "game_#{count_files}.yaml"
    File.open("/game_archive/#{filename}", 'w') { |file| file.write(save_game_to_yaml)}
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
    return 0 if Dir.empty?('/game_archive')

    dir = '/game_archive'
    Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
  end
end
