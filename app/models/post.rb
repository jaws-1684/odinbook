class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable, dependent: :destroy
  has_one_attached :image
  
  
  validates :title, presence: true, length: { minimum: 5, maximum: 280 }
  validates :body, presence: true, length: {minimum: 20, maximum: 2000 }

  after_create_commit do 
    broadcast_prepend_to "posts", target: "posts-container", partial: "posts/post", locals: { post: self }
  end

  after_update_commit do 
    broadcast_replace_to "posts", target: "post_#{self.id}", partial: "posts/post", locals: { post: self }
  end

  after_destroy_commit do 
    broadcast_remove_to "posts", target: "post_#{self.id}", partial: "posts/post", locals: { post: self }
  end

  def self.subscribed_to user
    subscriptions = where(user: user.friends).or(where(user: user)) 
  end
end
