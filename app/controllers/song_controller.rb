
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
    # @songsInPlaylist = PlaylistSong.where(hashed_id: session[:hashed_id]).join(:song).where(id: song.id).pluck(:song_id)

    # @temp = PlaylistSong.where(hashed_id: session[:hashed_id]).join(:Song).where('Song.id = PlaylistSong.song_id' )
    # @result = @temp.where(spotify_id: params[:spotify_id])

    @songsInPlaylist = PlaylistSong.where(hashed_id: session[:hashed_id]).pluck(:song_id)
    @temp = Song.find(@songsInPlaylist).select {|i| i.spotify_id == params[:spotify_id] }
    if @temp.length == 0
      @song = Song.create(name: params[:name], vote_count: 0, artist: params[:artist], spotify_id: params[:spotify_id])
      PlaylistSong.create(song_id: @song.id, hashed_id: session[:hashed_id])
      flash.now[:notice] = "Song was added to playlist!"
      redirect_to playlist_url
    end
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
    if @song = Song.find(params[:s_id].to_f)
      @song.update(vote_count: (@song.vote_count + 1))
      render json: { res: @song }
    else
      render json: {
        error: "Song with s_id: #{params[:s_id]} not found"
      }, status: :not_found
    end
  end

  def down_vote
    @song = Song.find(params[:s_id].to_f)
    @song.update(vote_count: (@song.vote_count - 1))
    render json: {res: @song}
  end
end
