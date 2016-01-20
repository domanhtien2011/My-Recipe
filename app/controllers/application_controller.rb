class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # User helper method so that they are also available in the views
  helper_method :current_user, :logged_in?

  # All the methods here will be available to all the controllers
  def current_user
    if session[:chef_id]
      @current_user ||= Chef.find(session[:chef_id])
    end
  end

  # use !! to return boolean value
  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = 'You must log in to perfor this action'
      redirect_to :back
    end
  end
end
