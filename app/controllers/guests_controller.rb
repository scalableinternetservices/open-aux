require 'bcrypt'
class GuestsController < ApplicationController
  def new
  end
  
  def change
    # debugger
    @hashed_id = BCrypt::Password.new(params[:key])
    session[:hashed_id] = @hashed_id
    redirect_to '/dashboard'
  end
end
