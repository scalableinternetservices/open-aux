class PlaylistController < ApplicationController
  def new
    @playlist = Playlist.new
  end
  def show
    @playlist = Playlist.find(params[:id])
  end 
  def create
    @playlist = Playlist.new(name: playlist_params[:name], userId: session[:user_id])
    @playlist.save
    session[:playlistId] = playlist.id
    redirect_to @playlist
  end 

  private
    def playlist_params
      params.require(:playlist).permit(:name)
    end
end


