class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to '/playlist'
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      log_in user
      session[:userId] = user.id
      spotifyAuth
      # redirect_to playlist_url
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
