get '/lobby' do
  @games = Game.where(player2: nil).reject {|game| game.player1 == current_user.id}
  erb :lobby
end


get '/games/new' do
  game = Game.create
  current_user.games_started << game
  redirect "/game/#{game.id}"
end

get '/game/:game_id' do
  erb :board
end

post '/:game_id/move' do
  cell = params[:cell_id]
  game = Game.find(game_id)
  game.moves += cell
  game.save
  200  
end

get '/game/:game_id/state' do |game_id|
  content_type :json

  game = Game.find(game_id)
  
  game.state.to_json

end
