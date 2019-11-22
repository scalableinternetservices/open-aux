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
      scope: %w(playlist-read-private user-read-private user-read-email).join(' '),
      redirect_uri: 'http://localhost:3000/auth/spotify/callback',
      show_dialog: true
      }
      url = 'https://accounts.spotify.com/authorize'
      redirect_to "#{url}?#{query.to_query}"
  end

end
