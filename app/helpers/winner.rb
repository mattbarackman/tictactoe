helpers do
  #string represents a sequence of moves: "582196734"

  def user_stats
    stats = {}
    stats[:wins] = current_user.wins.count
    stats[:draws] = current_user.games.select{ |game| game.winner == nil && game.moves.length == 9 }.count
    stats[:losses] = current_user.games.select{ |game| game.winner && game.winner != current_user.id }.count
    stats[:incomplete] = current_user.games.count - stats[:wins] - stats[:draws] - stats[:losses]
    stats
  end

end
# puts winner("518273") == "player2"
# puts winner("956378214") == "draw"
# puts winner("51827") == "continue"
# puts winner("") == "continue"