# Homepage (Root path)
get '/' do
  erb :index
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
  @song = Song.new(title: params[:title], author: params[:author], url: params[:url], vote: 0)
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
