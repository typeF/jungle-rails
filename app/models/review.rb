class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :product

  validates :user_id, :description, :rating, presence: true

end
