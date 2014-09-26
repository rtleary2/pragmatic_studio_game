require 'studio_game/clumsy_player'

module StudioGame
  
  describe ClumsyPlayer do
    before do
      $stdout = StringIO.new
      @player = ClumsyPlayer.new("klutz")
    end
    
    it "only gets half the point value for each treasure" do
      expect(@player.points).to eq 0

      hammer = Treasure.new(:hammer, 50)
      @player.found_treasure(hammer)
      @player.found_treasure(hammer)
      @player.found_treasure(hammer)

      expect(@player.points).to eq 75

      crowbar = Treasure.new(:crowbar, 400)
      @player.found_treasure(crowbar)
      
      expect(@player.points).to eq 275    
      
      yielded = []
      @player.each_found_treasure do |treasure|
        yielded << treasure
      end

      expect(yielded).to eq [Treasure.new(:hammer, 75), Treasure.new(:crowbar, 200)]    
    end

    context "with a boost" do
      before do
        @initial_health = 100
        @boost = 5
        @player = ClumsyPlayer.new("clumsy", @initial_health, @boost)
      end

      it "has a boost" do
        expect(@player.boost).to eq @boost
      end

      it "gets a boost number of w00ts for ever w00t" do
        @player.w00t
        expect(@player.health).to eq (@initial_health + (15 * @boost))
      end
    end

  end
end