class ProfilesController < ApplicationController
  before_action :set_profile, :set_posts

  def show
  end

  private

  def set_profile
    @profile = User.find_by(id: params[:id])
  end
  
  def set_posts
    @posts = @profile.posts
  end
end
