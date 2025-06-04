class FriendRequestsController < ApplicationController
  before_action :set_profile

  def index
  	@friends = @profile.friends
  end

  def show
  end

  private

 

  def set_profile
    @profile = User.find_by(id: params[:profile_id]) 
  end
end
