class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :miniprofiler

  def require_user
    redirect_to sign_in_path unless current_user
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  private

  def miniprofiler
    Rack::MiniProfiler.authorize_request if current_user != nil 
  end
end
