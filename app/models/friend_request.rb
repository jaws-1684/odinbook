class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  enum :status, { sent: 0, accepted: 1, declined: 1 }

 

end
