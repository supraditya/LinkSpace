class ApplicationController < ActionController::Base
  def authenticate_user!
    unless current_user
      redirect_to new_user_session_path
    end
  end
end
