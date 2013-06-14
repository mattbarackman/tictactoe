get '/' do
 @users = User.all
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page
  @errors = session.delete(:errors) if session[:errors] 
  erb :sign_in
end

post '/sessions' do
  
end

delete '/sessions/:id' do
  session[:user_id] = nil
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  @errors = session.delete(:errors) if session[:errors] 
  erb :sign_up
end

post '/users' do
  p params[:user]
  user = User.new(params[:user])
  if user.valid?
    user.save
    session[:user_id] = user.id
    redirect '/'
  else
    session[:errors] = user.errors
    @form_data = params[:user]
    redirect '/users/new'
  end
end
