require 'bcrypt'
require 'net/http'
require 'json'
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

    uri = URI('https://accounts.spotify.com/api/token')
    res = Net::HTTP.post_form(uri, 
    grant_type: 'client_credentials',
    client_id: Rails.application.credentials.spotify[:client_id],
    client_secret: Rails.application.credentials.spotify[:client_secret]
    )
    authParams = JSON.parse res.body
    session[:client_credentials] = authParams
    puts(res.body)

    redirect_to dashboard_url

  end
end
