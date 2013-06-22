get '/lobby' do
  @games_to_join = Game.where(player2: nil).reject {|game| game.player1 == current_user.id}
  @games_started = Game.where(player2: nil).select {|game| game.player1 == current_user.id}
  @user_stats = user_stats 
  erb :lobby
end


get '/games/new' do
  game = Game.create
  current_user.games_started << game
  redirect "/game/#{game.id}"
end

get '/game/:game_id' do |game_id|
  game = Game.find(game_id)
  game.player2 = current_user.id unless game.player1 == current_user.id
  game.save
  erb :board
end

post '/game/:game_id/move' do
  p params
  cell = params[:cell_id]
  p cell
  game = Game.find(params[:game_id])
  p game
  game.moves += cell unless game.moves.split("").include? cell
  game.save
  200  
end

get '/game/:game_id/state' do |game_id|
  content_type :json
  game = Game.find(game_id)
  if game.player2
    game.state 
    game.state.to_json
  else
    200
  end
end
