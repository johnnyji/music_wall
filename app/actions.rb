require "rack-flash"

use Rack::Flash
enable :sessions

get '/' do
  if logged_in?
    redirect to('/songs')
  else
    erb :index
  end
end

post '/users/create' do
  @user = User.new(name: params[:name], password: params[:password])
  if @user.save
    session[:user_id] = @user.id
    redirect to('/songs')
  else
    flash[:error] = "User already exists!"
    erb :index
  end
end

get '/login' do
  erb :'users/login'
end

post '/login' do
  @user = User.where(name: params[:name], password: params[:password]).first
  if @user.nil?
    flash[:error] = "Invalid Username or Password!"
    erb :index
  else 
    session[:user_id] = @user.id
    redirect to('/songs')
  end
end

get '/logout' do
  session.clear
  erb :index
end

get '/songs' do
  @songs = Song.all.order('created_at DESC')
  erb :'/songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'/songs/new'
end

post '/songs/create' do
  @song = Song.new(title: params[:title], author: params[:author], url: params[:url], user_id: session[:user_id])
  if @song.save
    redirect to('/songs')
  else
    erb :'songs/new'
  end
end

get '/songs/:id/upvote' do
  upvote = Upvote.new(user_id: current_user.id, song_id: params[:id])
  if upvote.save
    redirect to('/songs')
  else
    flash[:error] = "You can't upvote that song twice!"
    redirect to('/songs')
  end
end

get '/songs/:id/downvote' do
  downvote = Downvote.new(user_id: current_user.id, song_id: params[:id])
  if downvote.save
    redirect to('/songs')
  else
    flash[:error] = "You've already downvoted that song!"
    redirect to('/songs')
  end
end

get '/songs/:id/reviews' do
  @song = Song.find(params[:id])
  @reviews = @song.reviews.order('created_at DESC')
  erb :'reviews/show'
end

post '/songs/:song_id/reviews' do
  @review = Review.new(content: params[:content], song_id: params[:song_id], user_id: session[:user_id])
  if @review.save
    flash[:notice] = "Thanks for the review!"
    redirect to("/songs/#{params[:song_id]}/reviews")
  else
    flash[:error] = "You're comment wasn't saved properly"
    redirect to("/songs/#{params[:song_id]}/reviews")
  end
end

get '/songs/:song_id/reviews/:id/delete' do
  @review = Review.find(params[:id])
  @review.destroy
  flash[:notice] = 'Your post was succesfully deleted!'
  redirect to("/songs/#{params[:song_id]}/reviews")
end

# HELPERS
helpers do

  def logged_in?
    current_user != nil 
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "No user found!"
    erb :index
  end

end