class ApplicationController < ActionController::Base
    def home
    end
    
    protect_from_forgery with: :exception
    include SessionsHelper
end
