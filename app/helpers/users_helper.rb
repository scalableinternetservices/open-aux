require 'net/http'
require 'json'
module UsersHelper
  def reqAccessToken(params)
    uri = URI('https://accounts.spotify.com/api/token')
    res = Net::HTTP.post_form(uri, 
    grant_type: 'authorization_code',
    code: params[:code],
    redirect_uri: 'http://localhost:3000/auth/spotify/callback',
    client_id: Rails.application.credentials.spotify[:client_id],
    client_secret: Rails.application.credentials.spotify[:client_secret]
    )
    authParams = JSON.parse res.body
    @user = User.find_by(id: session[:userId])
    @user.update(accessToken: authParams['access_token'], refreshToken: authParams['refresh_token'])
  end
end
