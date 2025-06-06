class FriendRequestsController < ApplicationController
  before_action :set_friend_request

  def update
    @friend_request = FriendRequest.find(params[:id])

    if @friend_request.update(status: 1)
      redirect_to profile_friend_requests_path(current_user), notice: "Invitation accepted"
    else
      redirect_to profile_friend_requests_path(current_user), status: :unprocessable_entity  
    end  
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])

    if @friend_request.destroy
       redirect_to profile_friend_requests_path(current_user)
    else
       redirect_to profile_friend_requests_path(current_user), status: :unprocessable_entity  
    end  
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
end
