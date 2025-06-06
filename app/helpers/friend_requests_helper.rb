module FriendRequestsHelper
	  def find_friends user1, user2
      FriendRequest.find_by(user_id: user1.id, friend_id: user2.id, status: 1) ||
      FriendRequest.find_by(user_id: user2.id, friend_id: user1.id, status: 1)
    end

    def find_invitations user1, user2
      FriendRequest.find_by(user_id: user1.id, friend_id: user2.id, status: 0)
    end
end
