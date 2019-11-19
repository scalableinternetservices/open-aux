require 'bcrypt'
class GuestsController < ApplicationController
  def new
  end
  def change
    # debugger
    @hashed_id = BCrypt::Password.new(params[:key])
    session[:playlist_hashed_id] = @hashed_id
    render 'new'
  end
end
