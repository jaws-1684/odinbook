class FriendRequestsController < ApplicationController
  before_action :set_friend_request

  def update
    if @friend_request.accept!
      redirect_to profile_friend_requests_path(current_user), notice: "Invitation accepted"
    else
      redirect_to profile_friend_requests_path(current_user), status: :unprocessable_entity  
    end  
  end

  def destroy
    if @friend_request.destroy
       redirect_to profile_friend_requests_path(current_user)
    else
       redirect_to profile_friend_requests_path(current_user), status: :unprocessable_entity  
    end  
  end

  private

  def set_friend_request
    @friend_request = current_user.friend_requests.find(params[:id])
  end

  def accept!
     update(status: :accepted)
  end
  
end
