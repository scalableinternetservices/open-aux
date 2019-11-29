
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
    if !Song.exists?(spotify_id: params[:spotify_id])
      @song = Song.create(name: params[:name], artist: params[:artist], spotify_id: params[:spotify_id])
    else 
      @song = Song.where(spotify_id: params[:spotify_id]).first
    end
    @playlist = Playlist.where(hashed_id: session[:hashed_id]).first
    @playlist.playlist_songs.create(song_id: @song.id, hashed_id: @playlist.hashed_id, vote_count: 0)
    
    flash.now[:notice] = "Song was added to playlist!"
    redirect_to playlist_url
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


  def up_vote
    @playlist_song = PlaylistSong.where(song_id: params[:s_id].to_f, hashed_id: session[:hashed_id]).first
    @playlist_song.update(vote_count: (@playlist_song.vote_count + 1))
    @playlist_song.save()

    render json: { res: @song }
  end

  def down_vote
    @playlist_song = PlaylistSong.where(song_id: params[:s_id].to_f, hashed_id: session[:hashed_id]).first
    @playlist_song.update(vote_count: (@playlist_song.vote_count - 1))
    @playlist_song.save()
    render json: { res: @song }
  end
end
