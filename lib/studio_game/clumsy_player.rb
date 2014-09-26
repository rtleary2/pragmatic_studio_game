require_relative 'player'

module StudioGame
  class ClumsyPlayer < Player

    attr_reader :boost

    def initialize(name, health = 100, boost = 1)
      super(name, health)
      @boost = boost
    end

    def w00t
      @boost.times { super }
    end

    def found_treasure(treasure)
      super(Treasure.new(treasure.name, treasure.points / 2.0))
    end

  end

end
