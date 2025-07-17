class User < ApplicationRecord
  after_create :send_welcome_email
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
    parse_invitations_with(:user, friend_id: self, status: 1) +
      parse_invitations_with(:friend, user_id: self, status: 1)
  end

  def received_invitations
    parse_invitations_with(:user, friend_id: self, status: 0)
  end

  def sent_invitations
    parse_invitations_with(:friend, user_id: self, status: 0)
  end

  def self.search(query)
    unless query.length < 100 && query.match?(/^[a-z ,.'-]+$/i)
      return []
    end
    q = query.downcase.split(" ")
    result = []
    q.each do |term|
      fixed_search = where("lower(full_name) LIKE ?", "#{query.downcase}")
      unless fixed_search.empty?
        result << fixed_search
        break
      else
        result << where("email LIKE ?", "%#{term}%").or(where("lower(full_name) LIKE ?", "%#{term}%"))
      end
    end
    result.flatten.uniq
  end

  def country_name(c=country)
    return nil unless c
    country = ISO3166::Country[c]
    country.translations[I18n.locale.to_s] || country.common_name || country.iso_short_name
  end

  private
    def send_welcome_email
      UserMailer.with(user: self).welcome_email.deliver
    end

    def parse_invitations_with transform, **params
      FriendRequest.where(params).includes(transform).map(&transform).compact.uniq
    end
end
