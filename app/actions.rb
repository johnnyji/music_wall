# Homepage (Root path)
get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  erb :'/songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'/songs/new'
end

post '/songs/create' do
  binding.pry
  @song = Song.new(title: params[:title], author: params[:author], url: params[:url])
  if @song.save
    redirect to('/songs')
  else
    erb :'/songs/new'
  end
end
