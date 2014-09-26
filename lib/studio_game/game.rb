require_relative 'player'
require_relative 'game_turn'
require_relative 'treasure_trove'

module StudioGame
  class Game
    def initialize(name)
      @name = name
      @players = []
    end

    def add_player(player)
      @players << player
    end

    def total_points
      @players.reduce(0) {|sum, player| sum + player.points}
    end

    def load_players(filename)
      File.readlines(filename).each do |line|
        add_player(Player.from_csv(line))
      end
    end

    def save_high_scores(filename = 'high_scores.txt')
      File.open(filename, 'w') do |file|
        file.puts("#{@name} High Scores:")
        @players.sort.each do |player|
          file.puts high_score_entry_string(player)
      end
      end
    end

    def play(rounds)
      
      puts "There are #{@players.size} players in #{@name}: "
      @players.each do |player|
        player.print_name_and_health
      end

      treasures = TreasureTrove::TREASURES
      puts "\nThere are #{treasures.size} treasures to be found:"
      treasures.each do |treasure|
        puts "A #{treasure.name} is worth #{treasure.points} points."
      end


      1.upto(rounds) do |round|
        if block_given?
          break if yield
        end
        puts "\nRound #{round}:"
        @players.each do |player|
          # puts player
          StudioGame::GameTurn.take_turn(player)
          puts player
        end
      end
    end

    def high_score_entry_string(player)
      formatted_name = player.name.ljust(20, '.')
      "#{formatted_name} #{player.score}"
    end

    def print_stats
      strong_players, wimpy_players = @players.partition { |player| player.strong? }

      puts "\n#{@name} Statistics:"
      puts "\n#{strong_players.size} strong player(s):"
      strong_players.each do |player|
        player.print_name_and_health
      end

      puts "\n#{wimpy_players.size} wimpy player(s):"
      wimpy_players.each do |player|
        player.print_name_and_health
      end

      @players.each do |player|
        puts "\n#{player.name}'s point totals:"
        player.each_found_treasure do |treasure| 
          puts "#{treasure.points} total #{treasure.name} points"
        end
        puts "#{player.points} grand total points"
      end

      puts "\n#{total_points} total points from treasures found"

      puts "\n#{@name} High Scores:"
      @players.sort.each do |player|
        puts high_score_entry_string(player)
      end
    end

  end

end