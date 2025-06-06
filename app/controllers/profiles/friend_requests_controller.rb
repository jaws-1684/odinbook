class Profiles::FriendRequestsController < ApplicationController
	before_action :set_profile

  def index
  	@friends = @profile.friends
  end

  def new
    @friend_request = FriendRequest.new
  end

  def create
   @friend_request = current_user.friend_requests.build(friend_id: params[:profile_id], status: 0)

    if @friend_request.save
      redirect_to profile_path(@profile), notice: "Invitation sent"
    else
      redirect_to profile_path(@profile), notice: "nobody likes you", status: :unprocessable_entity  
    end  

  end

  private

  def set_profile
    @profile = User.find_by(id: params[:profile_id]) 
  end
end
