
class SongController < ApplicationController

  def new
    @song = Song.new
  end

  def play 
    helpers.playSongFromAPI(params[:spotify_id])
  end

  def pause
    pauseSongFromAPI(params[:spotify_id])
  end
  
  def create
    # @song = Song.create(name: nil, vote_count: 0, arist: nil, spotify_id: nil)
    # @song = Song.new(name: song_params[:name], vote_count: 0, artist: song_params[:artist], spotify_id: song_params[:spotify_id])
    @song = Song.create(name: params[:name], vote_count: 0, artist: params[:artist], spotify_id: params[:spotify_id])
    PlaylistSong.create(song_id: @song.id, hashed_id: session[:hashed_id])
  end

  def show
    @trackList = []
    render 'show'
  end

  def search
    @trackList = helpers.getSongsFromAPI(params[:q])
    #@trackList = helpers.getSongsFormAPI(search_params[:name])
    render 'show'
  end

end
