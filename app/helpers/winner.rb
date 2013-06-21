helpers do
  #string represents a sequence of moves: "582196734"

  WINNING_BLOCKS = ["123", "456", "789", "147", "258", "369", "159", "357"]
  def continue?(game_string)
    winner(game_string) == "continue"
  end

  def winner(game_string)
    game_moves = game_string.split('')
    p1 = []
    game_moves.each_index { |x| p1 << game_string[x] if x % 2 == 0 }
    p2 = game_moves - p1

    WINNING_BLOCKS.each do |block|
      block_array = block.split('')
      if block_array.reduce(true) { |result, next_item| result && p1.include?(next_item) }
        return "player1"
      elsif block_array.reduce(true) { |result, next_item| result && p2.include?(next_item) }
        return "player2"
      end
    end

    game_string.length == 9 ? "draw" : "continue"

  end

end
# puts winner("518273") == "player2"
# puts winner("956378214") == "draw"
# puts winner("51827") == "continue"
# puts winner("") == "continue"