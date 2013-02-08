class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_login
  # before_filter :check_access

  private

  def check_access(user)
    unless has_access?(user)
      flash[:error] = "You do not have access to that page"
      puts "AM I HERE???"
      redirect_to @current_user
    end
  end

  def has_access?(user)
    @current_user && user && @current_user.id == user.id
  end

  def require_login
    unless logged_in?
      flash[:error] = "YOU NEED TO LOG IN"
      redirect_to root_path
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    unless session[:token].nil?
      @current_user = User.find_by_session_token(session[:token])
    else
      nil
    end
  end

  def is_friend?(user)
    @current_user && user && @current_user.travelers.include?(user)
  end
end
