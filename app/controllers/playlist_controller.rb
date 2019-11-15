require 'bcrypt'
class PlaylistController < ApplicationController
  def new
    @playlist = Playlist.new
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
    session[:playlist_hashed_id] = @playlist.hashed_id
    render "bogus_landing_page"
  end 

  # returns a hashed value of the playlist's hashed_id
  # guest can then decode that and access the playlist w/ the hashed_id
  def get_playlist_key
    @key = BCrypt::Password.new(session[:playlist_hashed_id])
    render 'get_playlist_key'
  end

  private
    def playlist_params
      params.require(:playlist).permit(:name)
    end
end


