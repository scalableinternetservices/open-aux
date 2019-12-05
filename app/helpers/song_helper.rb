require 'rspotify'
require 'net/http'
require 'json'
# options = {'credentials': af667ed038f04c8cb5804570c3ca2c43}
# debugger
# user = RSpotify::User.find('22hoeq7p2cuju6rcyqmsrfcba')
# credentials = user.client_token


# af667ed038f04c8cb5804570c3ca2c43
# 99dcf1d0dd8544dd95344ed1f37f3c4d
module SongHelper
  def getSongsFromAPI(stringQuery)
    if logged_in?
      @user = User.find_by(id: session[:userId])

      uri = URI('https://api.spotify.com/v1/search')
      params = { :q => stringQuery, :limit => 10, :type => ['track'], :access_token => @user["accessToken"] }
      uri.query = URI.encode_www_form(params)

      res = Net::HTTP.get_response(uri)
    else 
      uri = URI('https://api.spotify.com/v1/search')
      params = { :q => stringQuery, :limit => 10, :type => ['track'], :access_token => session[:client_credentials]["access_token"] }
      uri.query = URI.encode_www_form(params)

      res = Net::HTTP.get_response(uri)
    end
    return JSON.parse res.body
  end

  def playSongFromAPI(trackId)
    
    session[:player].play_track('4398fd8d756dfb8a0afb14c3790b5fa47f0f8003', "spotify:track:" + trackId)
  end

  def pauseSongFromAPI(trackId)
    # player = session[:hostUser].player
    session[:player].pause
  end
    
end
