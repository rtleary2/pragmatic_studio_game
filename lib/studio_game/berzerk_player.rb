require_relative 'player'

module StudioGame
  
  class BerzerkPlayer < Player

    def initialize(name, health = 100)
      super(name, health)
      @w00t_count = 0
    end

    def berzerk?
      @w00t_count > 5
    end

    def w00t
      super
      @w00t_count += 1
      puts "#{@name} is berserk!" if berzerk?
    end

    def blam
      berzerk? ? w00t : super
    end
  
  end

end
