require 'bcrypt'
class PlaylistController < ApplicationController
  def new
    @playlist = Playlist.new
  end

  def show
    @key = BCrypt::Password.new(session[:hashed_id])
    @playlist = Playlist.where(hashed_id=session[hashed_id])
    @hashed_id = session[:hashed_id]
    if params[:search]
      @songs = Song.where("lower(name) LIKE ? OR lower(artist) LIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%").where( id: PlaylistSong.where(hashed_id: @hashed_id).pluck(:song_id) ).order('vote_count DESC')
    else
      @songs = Song.where( id: PlaylistSong.where(hashed_id: @hashed_id).pluck(:song_id) ).order('vote_count DESC')
    end
  end 

  # store the hashed value of the playlist_id into the playlist model
  # this allows protected access to each playlist instance
  def create
    @playlist = Playlist.create(name: playlist_params[:name], userId: session[:user_id], hashed_id: nil)
    hashed_id = BCrypt::Password.create(@playlist.id)
    @playlist[:hashed_id] = hashed_id
    @playlist.save()
    session[:hashed_id] = @playlist.hashed_id
    @key = BCrypt::Password.new(session[:hashed_id])
    @songs = Song.where( id: PlaylistSong.where(hashed_id: @hashed_id).pluck(:song_id), name: "ABDDSFLKS" ).order('vote_count DESC')
    render "show"
  end 

  # returns a hashed value of the playlist's hashed_id
  # guest can then decode that and access the playlist w/ the hashed_id
  def get_playlist_key
    @key = BCrypt::Password.new(session[:hashed_id])
    render json: {key: @key}
  end

  def get_songs
    #puts session[:hashed_id]
    @hashed_id = session[:hashed_id]
    @songs = Song.where( id: PlaylistSong.where(hashed_id: @hashed_id).pluck(:song_id) )
    
    render json: {res: @songs}
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

  private
    def playlist_params
      params.require(:playlist).permit(:name)
    end
end
