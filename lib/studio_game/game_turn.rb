require_relative 'player'
require_relative 'die'
require_relative 'loaded_die'
require_relative 'treasure_trove'

module StudioGame

  module GameTurn
  
    def self.take_turn(player)
      die = Die.new

      case die.roll
      when 1..2
        player.blam
      when 3..4
        puts "#{player.name} was skipped."
      else
        player.w00t
      end
      treasure_found = TreasureTrove.random
      player.found_treasure(treasure_found)
    end

  end

end
