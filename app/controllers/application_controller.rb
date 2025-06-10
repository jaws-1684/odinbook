class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.

  layout :layout_by_resource
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :set_user_id_cookie
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected
   def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :avatar_url, :full_name, :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :full_name, :avatar_url, :email, :password, :password_confirmation, :current_password) }
   end

  private

  def set_user_id_cookie
    cookies[:current_user_id] = current_user.id if user_signed_in?
  end


  def layout_by_resource
      # turbo frames fix https://github.com/hotwired/turbo-rails#a-note-on-custom-layouts
      return "turbo_rails/frame" if turbo_frame_request?

      case controller_name
        when "posts" then "feed"
        when "profiles" then "profile"
        when "friend_requests" then "profile"  
        else "application"
      end
  end

 

end
