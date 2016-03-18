class ArtistsController < ApplicationController
  # index
  def index
    @artists = Artist.all
  end

  # new
  def new
    return unless authorized
    @artist = Artist.new
  end

  # create
  def create
    return unless authorized
    @artist = @current_user.artists.create!(artist_params)

    redirect_to @artist
  end

  #show
  def show
    @artist = Artist.find(params[:id])
  end

  # edit
  def edit
    return unless authorized
    @artist = Artist.find(params[:id])
  end


  # update
  def update
    return unless authorized
    @artist = Artist.find(params[:id])
    @artist.update(artist_params)

    redirect_to @artist
  end

  # destroy
  def destroy
    return unless authorized
    @artist = Artist.find(params[:id])
    @artist.destroy

    redirect_to artists_path
  end

  private
  def artist_params
    params.require(:artist).permit(:name, :photo_url, :nationality)
  end
end

class SongsController < ApplicationController
  # index
  def index
    @songs = Song.all
  end

  # new
  def new
    return unless authorized
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.new
  end

  # create
  def create
    return unless authorized
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.new(song_params)
    @song.user = @current_user
    @song.save

    redirect_to @song
  end

  #show
  def show
    @song = Song.find(params[:id])
  end

  # edit
  def edit
    return unless authorized
    @song = Song.find(params[:id])
  end

  # update
  def update
    return unless authorized
    @song = Song.find(params[:id])
    @song.update(song_params)

    redirect_to @song
  end

  # destroy
  def destroy
    return unless authorized
    @song = Song.find(params[:id])
    @song.destroy

    redirect_to songs_path
  end

  private
  def song_params
    params.require(:song).permit(:title, :album, :preview_url, :artist_id)
  end
end
