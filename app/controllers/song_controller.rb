
class SongController < ApplicationController
  def new
    @song = Song.new
  end
  
  def create
    @song = Song.create(name: nil, vote_count: 0, arist: nil)
    PlaylistSong.create(song_id: @song.id, playlist_id: session[:playlist])
  end

  def search
    @trackList = helpers.getSongsFromAPI('wanna know')
    render 'search'
  end

end
