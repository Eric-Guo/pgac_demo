class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_current_user, if: -> { cookies[:fingerprint].present? }

  private

  def set_current_user
    Current.user = User.find_or_create_by(fingerprint: cookies[:fingerprint])
  end
end
