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

post '/move' do

  game_id = params[:game_id]
  cell = params[:cell_id]
  

end

get '/game/:game_id/state' do
  content_type :json

end


