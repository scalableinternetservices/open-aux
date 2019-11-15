
class SongController < ApplicationController
  def new
    @song = Song.new
  end
  
  def create
    @song = Song.create(name: nil, vote_count: 0, arist: nil, spotify_id: nil)
    #@song = Song.new(name: song_params[:name], vote_count: 0, artist: song_params[:artist], spotify_id: song_params[:spotify_id])
    PlaylistSong.create(song_id: @song.id, playlist_id: session[:playlist])
  end

  def search
    @trackList = helpers.getSongsFromAPI('wanna know')
    #@trackList = helpers.getSongsFormAPI(search_params[:name])
    render 'search'
  end

end