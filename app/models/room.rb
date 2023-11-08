class Room < ApplicationRecord
  validates :description, :name, :size, :max_people, :price, presence: true
  belongs_to :guesthouse
  has_many :custom_price

  enum status: { inactive: 0, active: 1 }
end
