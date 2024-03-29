require_relative 'treasure_trove'
require_relative 'playable'

module StudioGame
  class Player
    include Playable

    attr_accessor :name, :health

    def initialize(name, health = 100)
      @name = name.capitalize
      @health = health
      @found_treasures = Hash.new(0)
    end

    def to_s
      "I'm #{@name} with a health = #{health}, points = #{points}, and score = #{score}."
    end

    def name=(new_name)
      @name = new_name.capitalize
    end

    def score
      @health + points
    end

    def points
      @found_treasures.values.reduce(0,:+)
    end

    def <=> (other_player)
      other_player.score <=> score
    end

    def self.from_csv(line)
      name, health = line.split(',')
      Player.new(name, Integer(health))
    end

    def found_treasure(treasure)
      @found_treasures[treasure.name] += treasure.points
      puts "#{@name} found a #{treasure.name} worth #{treasure.points} points."
      puts "#{@name}'s treasures: #{@found_treasures}"
    end

    def each_found_treasure
      @found_treasures.each do |name, points|
        yield Treasure.new(name, points)
      end
    end

    def print_name_and_health
      puts "#{@name} (#{@health})"
    end

  end

end
