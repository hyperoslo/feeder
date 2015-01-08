class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper Feeder::AuthorizationHelper
  helper Feeder::LikeHelper

  protected

  def current_user
    User.first
  end
end
