class ApplicationController < ActionController::Base
    helper_method :current_user
  
    private
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  
    def require_login
      unless current_user
        redirect_to login_path, alert: 'Vous devez être connecté pour accéder à cette section'
      end
    end
  end
  