class PlaylistController < ApplicationController
  def new

  end
  def show
    @playlist = Playlist.find(params[:name])
  end 
  def create
    @playlist = Playlist.new(playlist_params)

    redirect_to playlist_show_url
  end 

  private
    def playlist_params
      params.require(:playlist).permit(:name)
    end
end


