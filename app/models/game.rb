class Game < ActiveRecord::Base

  # Remember to create a migration!

  WINNING_BLOCKS = ["123", "456", "789", "147", "258", "369", "159", "357"]
  def continue?
    determine_winner! == "continue"
  end

  def determine_winner!
    game_string = self.moves
    game_moves = game_string.split('')
    p1 = []
    game_moves.each_index { |x| p1 << game_string[x] if x % 2 == 0 }
    p2 = game_moves - p1

    WINNING_BLOCKS.each do |block|
      block_array = block.split('')
      if block_array.reduce(true) { |result, next_item| result && p1.include?(next_item) }
        declare_winner!(player1)
        return winner.name
      elsif block_array.reduce(true) { |result, next_item| result && p2.include?(next_item) }
        declare_winner!(player2)
        return winner.name
      end
    end

    if game_string.length == 9 
      self.winner = nil
      "draw"
    else
      "continue"
    end
  end

  private

  def declare_winner!(player)
    self.winner = player
  end
end
