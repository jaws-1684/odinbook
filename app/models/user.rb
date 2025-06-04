class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, omniauth_providers: %i[google_oauth2 github]
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy

  has_many :friend_requests, dependent: :destroy
 
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      return user unless user.new_record?
      
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def friends
    sent = FriendRequest.where(user_id: self.id, status: 0).includes(:friend).map(&:friend)
    received = FriendRequest.where(friend_id: self.id, status: 0).includes(:user).map(&:user)
    (sent + received).uniq
  end

end
