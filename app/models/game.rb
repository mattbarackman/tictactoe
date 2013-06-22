class Game < ActiveRecord::Base

  # Remember to create a migration!

  WINNING_BLOCKS = ["123", "456", "789", "147", "258", "369", "159", "357"]

  def find_winner
    game_string = self.moves
    game_moves = game_string.split('')
    p1 = []
    game_moves.each_index { |x| p1 << game_string[x] if x % 2 == 0 }
    p2 = game_moves - p1

    user_one = User.find(self.player1)
    user_two = User.find(self.player2)
    

    WINNING_BLOCKS.each do |block|
      block_array = block.split('')
      if block_array.reduce(true) { |result, next_item| result && p1.include?(next_item) }
        declare_winner!(user_one)
        return user_one.name
      elsif block_array.reduce(true) { |result, next_item| result && p2.include?(next_item) }
        declare_winner!(user_two)
        return user_two.name
      end
    end
    false
  end

  def continue?
    p self.find_winner
    !(self.find_winner || self.moves.length == 9)
  end

  def declare_winner!(winner)
    winner.wins << self
    winner.save
  end

  def current_turn
    self.moves.length % 2 + 1
  end

  def state

    {:continue => self.continue?,
    :outcome => self.find_winner || "draw", 
    :cells => self.cells, #     ["","","O","","X","","O","","X"]
    :current_turn => current_turn,
    :current => 1} # either integer 1 or 2
  end


  def cells
    cell_grid = [""] * 9
    player = "X"
    self.moves.split('').each do |position|
      cell_grid[position.to_i - 1] = player
      player = (player == "X" ? "O" : "X")
    end
    cell_grid
  end

end


