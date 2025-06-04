class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable, dependent: :destroy
  
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: {minimum: 20}
end
