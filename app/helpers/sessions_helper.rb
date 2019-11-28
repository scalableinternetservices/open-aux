module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end


  def spotifyAuth
    # uri = URI('http://example.com/index.html')
    puts Rails.application.credentials.spotify[:client_id]
    query = { 
      client_id: Rails.application.credentials.spotify[:client_id], 
      response_type: 'code',
      scope: "playlist-read-private user-read-private user-read-email streaming user-modify-playback-state",
      redirect_uri: 'http://localhost:3000/auth/spotify/callback',
      show_dialog: true
      }
      url = 'https://accounts.spotify.com/authorize'
      redirect_to "#{url}?#{query.to_query}"
      debugger
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
  session.delete(:user_id)
  @current_user = nil
  end

end
