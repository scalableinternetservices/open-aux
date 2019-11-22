require 'bcrypt'
class PlaylistController < ApplicationController
  def new
    @playlist = Playlist.new
    # session[:credentials] = request.env['omniauth.auth'].credentials
    # debugger
    # request.env['omniauth.auth'].uid
  end

  def show
    @playlist = Playlist.find(params[:id])
  end 

  # store the hashed value of the playlist_id into the playlist model
  # this allows protected access to each playlist instance
  def create
    @playlist = Playlist.create(name: playlist_params[:name], userId: session[:user_id], hashed_id: nil)
    hashed_id = BCrypt::Password.create(@playlist.id)
    @playlist[:hashed_id] = hashed_id
    @playlist.save()
    session[:hashed_id] = @playlist.hashed_id
    render "show"
  end 

  # returns a hashed value of the playlist's hashed_id
  # guest can then decode that and access the playlist w/ the hashed_id
  def get_playlist_key
    @key = BCrypt::Password.new(session[:hashed_id])
    render json: {key: @key}
  end

  def get_songs
    #$2a$12$WLdfEmz4.vruvFQS7RU8weHZuzscgdf5TceVD4wm.L0uH9jHzAkWq
    @hashed_id = session[:hashed_id]
    @songs = Song.where( id: PlaylistSong.where(hashed_id: @hashed_id).pluck(:song_id) )

    render json: {res: @songs}
  end

  #req: :key, :name
  def decrypt_key
    @hashed_id = BCrypt::Password.new(params[:key])
    session[:name] = params[:name]
    #redirect_to playlist_mainpage
  end

  private
    def playlist_params
      params.require(:playlist).permit(:name)
    end
end
