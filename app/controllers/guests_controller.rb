require 'bcrypt'
class GuestsController < ApplicationController
  def new
  end

#   def change
#     # debugger
#     @hashed_id = BCrypt::Password.new(params[:key])
#     session[:playlist_hashed_id] = @hashed_id
   

  
  def create
    @hashed_id = BCrypt::Password.new(params[:session][:key])
    session[:hashed_id] = @hashed_id
    @playlist = Playlist.where(hashed_id=session[hashed_id])
    @songs = Song.where( id: PlaylistSong.where(hashed_id: @hashed_id).pluck(:song_id) ).order('vote_count DESC')
    #render 'search'
    redirect_to dashboard_url

  end
end
