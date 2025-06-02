class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :set_user_email_cookie

  private

  def set_user_email_cookie
    cookies[:current_user_email] = current_user.email if user_signed_in?
  end
end
