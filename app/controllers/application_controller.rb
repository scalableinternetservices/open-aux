class ApplicationController < ActionController::Base
    def home
    end
    
    # protect_from_forgery with: :exception
    skip_before_action :verify_authenticity_token
    protect_from_forgery with: :null_session

    include SessionsHelper
end
