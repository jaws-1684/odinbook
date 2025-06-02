class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: {minimum: 20}
end
