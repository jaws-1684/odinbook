class Address < ApplicationRecord
  belongs_to :user
  
  validates :country, length: { maximum: 5 }
  validates :city, length: { maximum: 20 }
end
