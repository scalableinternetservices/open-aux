require 'bcrypt'
class PlaylistController < ApplicationController
  include ActionController::Live
  # helper_method :fetchNewSong, :songEnded
  def new
    @playlist = Playlist.new
    # session[:credentials] = request.env['omniauth.auth'].credentials
    # debugger
    # request.env['omniauth.auth'].uid
  end

  def show
    @key = BCrypt::Password.new(session[:hashed_id])
    @playlist = Playlist.where(hashed_id=session[hashed_id])
    @hashed_id = session[:hashed_id]
    if params[:search]
      # deprecated
      # @songs = Song.where("lower(name) LIKE ? OR lower(artist) LIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%").where( id: PlaylistSong.where(hashed_id: @hashed_id).pluck(:song_id) ).order('vote_count DESC')

      # updated, valid
      @songs = Song.where("lower(name) LIKE ? OR lower(artist) LIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%").joins(:playlist_songs).where(playlist_songs:{hashed_id: session[:hashed_id] }).select("songs.*, playlist_songs.vote_count").order('vote_count DESC')

    else
      # deprecated
      # @songs = Song.where( id: PlaylistSong.where(hashed_id: @hashed_id).pluck(:song_id) ).order('vote_count DESC')

      # updated, valid
      @songs = Song.joins(:playlist_songs).where(playlist_songs:{hashed_id: session[:hashed_id] }).select("songs.*, playlist_songs.vote_count").order('vote_count DESC')
    end
    if logged_in?
    @accessToken = User.find_by(id: session[:userId]).accessToken
    end
    # @initializePlaylist = fetchNewSong
    # @firstVisit = 0
  end 

  # store the hashed value of the playlist_id into the playlist model
  # this allows protected access to each playlist instance
  def create
    if playlist_params[:name].blank?
      flash.now[:error] = 'Please enter playlist name!'
      @playlist = Playlist.new
      render 'new'
    else
      @playlist = Playlist.create(name: playlist_params[:name], user_id: session[:user_id], hashed_id: nil)
      hashed_id = BCrypt::Password.create(@playlist.id)
      @playlist[:hashed_id] = hashed_id
      @playlist.save()
      session[:hashed_id] = @playlist.hashed_id
      @key = BCrypt::Password.new(session[:hashed_id])    
      # Deprecated line:  
      # @songs = Song.where( id: PlaylistSong.where(hashed_id: @hashed_id).pluck(:song_id), name: "ABDDSFLKS" ).order('vote_count DESC')
      
      # updated, valid
      @songs = Song.joins(:playlist_songs).where(playlist_songs:{hashed_id: session[:hashed_id] }).select("songs.*, playlist_songs.vote_count").order('vote_count DESC')
      @firstVisit = 0
      render "show"
    end
  end 

  def get_json
    @playlist = Playlist.where(hashed_id=session[hashed_id])
    @hashed_id = session[:hashed_id]
    if params[:search]
      @songs = Song.where("lower(name) LIKE ? OR lower(artist) LIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%").joins(:playlist_songs).where(playlist_songs:{hashed_id: session[:hashed_id] }).select("songs.*, playlist_songs.vote_count").order('vote_count DESC')
    else
      @songs = Song.joins(:playlist_songs).where(playlist_songs:{hashed_id: session[:hashed_id] }).select("songs.*, playlist_songs.vote_count").order('vote_count DESC')
    end
    # debugger
    render json: {res: @songs}
  end

  def trackState
    @playlist = Playlist.where(hashed_id=session[hashed_id])
    @hashed_id = session[:hashed_id]
    if params[:search]
      @songs = Song.where("lower(name) LIKE ? OR lower(artist) LIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%").joins(:playlist_songs).where(playlist_songs:{hashed_id: session[:hashed_id] }).select("songs.*, playlist_songs.vote_count").order('vote_count DESC')
    else
      @songs = Song.joins(:playlist_songs).where(playlist_songs:{hashed_id: session[:hashed_id] }).select("songs.*, playlist_songs.vote_count").order('vote_count DESC')
    end
    # debugger
    session[:currentSongId] = @songs[0].id
    render json: {res: @songs}
  end

  def fetchNewSongAndDeleteOld
    @playlist = Playlist.where(hashed_id=session[hashed_id])
    @hashed_id = session[:hashed_id]
    @songs = PlaylistSong.where(hashed_id: session[:hashed_id], song_id: session[:currentSongId]).first
    @songs.destroy 
  end

  def get_playlist_key
    @key = BCrypt::Password.new(session[:hashed_id])
    render json: {key: @key}
  end

  def get_songs
    puts session[:hashed_id]
    @hashed_id = session[:hashed_id]
    @songs = Song.where( id: PlaylistSong.where(hashed_id:"$2a$12$oueH0DxM8ZoyW2bODWtDhOI/jEpHW.8HhHN3eCzXsZzbrAYgWdVEC").pluck(:song_id) )

    # render json: {res: @songs, res2: @songs2}

    @hashed_id = session[:hashed_id]
    # Working model
    debugger
    @songsInPlaylist = Song.joins(:playlist_songs).where(playlist_songs:{hashed_id:@hashed_id }).select("songs.*, playlist_songs.vote_count").order('vote_count DESC')
    @songs1 = Song.where( id: PlaylistSong.where(hashed_id: @hashed_id ).pluck(:song_id))
    render json: {res: @songsInPlaylist, res2: @songs1}
  end


  # test version - change this to get_songs (the def above) and deprecate the current version of get_songs
  def test_get_songs
    @hashed_id = session[:hashed_id]
    # Working model
    @songsInPlaylist = Song.joins(:playlist_songs).where(playlist_songs:{hashed_id:"$2a$12$87gsPmnazedML05/f5YHGOgcHisAvzDCKIrcWY.q.lBfrQkfyiJle" }).select("songs.*, playlist_songs.vote_count").order('vote_count DESC')
    #@songs1 = Song.where( id: PlaylistSong.where(hashed_id: "$2a$12$oueH0DxM8ZoyW2bODWtDhOI/jEpHW.8HhHN3eCzXsZzbrAYgWdVEC").pluck(:song_id))
    render json: {res: @songsInPlaylist, res2: @songs1}
  end

  #req: :key, :name
  def decrypt_key
    @hashed_id = BCrypt::Password.new(params[:key])
    session[:hashed_id] = @hashed_id
  end

  def route_playlist
    @hashed_id = params[:hashed_id]
    session[:hashed_id] = @hashed_id
    redirect_to "/dashboard"
  end

  def dashboard
    @accessToken = User.find_by(id: session[:userId]).accessToken
    render 'dashboard'
  end

  def update
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream, retry: 300, event: "updateQueue")
    begin
      PlaylistSong.on_change do |data|
        sse.write(event: 'updateQueue')
      end
    rescue IOError
      # Client Disconnected
    ensure
      sse.close
    end
    render nothing: true
  end
  

  private
    def playlist_params
      params.require(:playlist).permit(:name)
    end
end
