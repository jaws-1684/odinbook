class FriendRequest < ApplicationRecord
  validates_uniqueness_of :user_id, :scope => [:friend_id]
  validate :cannot_friend_yourself

  belongs_to :user
  belongs_to :friend, class_name: "User"

  enum :status, { sent: 0, accepted: 1}

 def cannot_friend_yourself
  error.add(:friend_id, "can't be yourself") if user.id == friend.id
 end

end
