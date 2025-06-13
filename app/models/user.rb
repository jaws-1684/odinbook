class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, omniauth_providers: %i[google_oauth2 github]
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friend_requests, dependent: :destroy
  has_one_attached :avatar
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true
  delegate :city, :country, to: :address, allow_nil: true

  
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
    sent = FriendRequest.where(user_id: self.id, status: 1).includes(:friend).map(&:friend)
    received = FriendRequest.where(friend_id: self.id, status: 1).includes(:user).map(&:user)
    (sent + received).compact.uniq
  end

  def received_invitations
    received = FriendRequest.where(friend_id: self.id, status: 0).includes(:user).map(&:user)
    received.compact.uniq
  end

  def sent_invitations
    sent = FriendRequest.where(user_id: self.id, status: 0).includes(:friend).map(&:friend)
    sent.compact.uniq
  end

  def self.search query
    q = query.downcase.split(" ")

    result = []
    q.each do |term|
      fixed_search = where('lower(full_name) LIKE ?', "#{query.downcase}")
      unless fixed_search.empty?
        result << fixed_search
        break
      else
        result << where("email LIKE ?", "%#{term}%").or(where("lower(full_name) LIKE ?", "%#{term}%")) 
      end      
    end
    result.flatten.uniq
  end

  def country_name country
    country = ISO3166::Country[country]
    country.translations[I18n.locale.to_s] || country.common_name || country.iso_short_name
  end

end
