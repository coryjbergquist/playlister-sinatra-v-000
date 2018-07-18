class SongsController < ApplicationController



  get "/songs" do
     @songs = Song.all
    erb :songs
  end

  get "/songs/new" do
    erb :songs_new
  end

  post "/songs/new" do
    @song = Song.create(name: params[:Name])
    @genres = Genre.find_by(name: params[:genre])
    if @genres
        @song.genres << @genres
      else
        new_genre = Genre.create(name: @genres)
        @song.genres << new_genre
      end
    @artist = Artist.find_by(name: params["Artist Name"])
    if @artist
      @song.artist = @artist
    else
    @song.artist = Artist.create(name: params["Artist Name"])
  end
    @song.save
    redirect "/songs/#{@song.slug}"
  end

  get "/songs/:slug/edit" do
    erb :songs_edit
  end



  get "/songs/:slug" do
    @song = Song.find_by_slug(params[:slug])
    erb :songs_show
  end

end
