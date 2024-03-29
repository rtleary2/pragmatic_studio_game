require 'studio_game/game'

module StudioGame
  describe Game do

    before do
      $stdout = StringIO.new
      @game = Game.new("Knuckleheads")
      @initial_health = 100
      @player = Player.new("moe", @initial_health)
      @game.add_player(@player)
    end

    it "w00ts a player when a high number is rolled" do
      allow_any_instance_of(Die).to receive(:roll).and_return(5)
      @game.play(3)
      expect(@player.health).to eq(@initial_health + 15 * 3)
    end

    it "skips a player when a medium number is rolled" do
      allow_any_instance_of(Die).to receive(:roll).and_return(3)
      @game.play(3)
      expect(@player.health).to eq(@initial_health)
    end

    it "blams a player when a low number is rolled" do
      allow_any_instance_of(Die).to receive(:roll).and_return(1)
      @game.play(3)
      expect(@player.health).to eq(@initial_health - 10 * 3)    
    end

    it "assigns a treasure for points during a player's turn" do     
      game = Game.new("Knuckleheads")
      player = Player.new("moe")
         
      game.add_player(player)
      
      game.play(1)
    
      expect(player.points).not_to be_zero
    end

    it "computes total points as the sum of all player points" do
      game = Game.new("Knuckleheads")
      
      player1 = Player.new("moe")
      player2 = Player.new("larry")
      
      game.add_player(player1)
      game.add_player(player2)
      
      player1.found_treasure(Treasure.new(:hammer, 50))
      player1.found_treasure(Treasure.new(:hammer, 50))
      player2.found_treasure(Treasure.new(:crowbar, 400))
      
      expect(game.total_points).to eq 500
    end
    
  end
end