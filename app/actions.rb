# Homepage (Root path)
enable :sessions

get '/' do
  erb :index
end

post '/users/create' do
  @user = User.new(name: params[:name], password: params[:password])
  if @user.save
    session[:user_id] = @user.id
    redirect to('/songs')
  else
    erb :index
  end
end

get '/login' do
  erb :'users/login'
end

post '/login' do
  begin
    @user = User.where(name: params[:name], password: params[:password]).first
    redirect to('/songs')
  rescue ActiveRecord::RecordNotFound
    erb :'users/login'
  end
end

post '/logout' do
  session.clear
  redirect to('/songs')
end

get '/songs' do
  @songs = Song.all.order('vote DESC')
  erb :'/songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'/songs/new'
end

post '/songs/create' do
  @song = Song.new(title: params[:title], author: params[:author], url: params[:url], vote: 0, user_id: session[:user_id])
  if @song.save
    redirect to('/songs')
  else
    erb :'songs/new'
  end
end

get '/songs/:id/upvote' do
  @song = Song.find(params[:id])
  @song.vote += 1
  @song.save
  redirect to('/songs')
end

get '/songs/:id/downvote' do
  @song = Song.find(params[:id])
  @song.vote -= 1
  @song.save
  redirect to('/songs')
end


# HELPERS
helpers do

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user != nil
  end

end