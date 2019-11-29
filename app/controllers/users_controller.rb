class UsersController < ApplicationController
  def show
      @user = User.find(params[:id])
  end

  def new
      @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      flash.now[:danger] = "Signup Error!"
      render 'new'
    end
  end

  def user_playlists
    @playlists = Playlist.where(user_id: session[:user_id])
    render json: {res: @playlists}
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
