class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.

  layout :layout_by_resource
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :set_user_id_cookie

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
