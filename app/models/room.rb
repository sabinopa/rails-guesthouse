class Room < ApplicationRecord
  validates :description, :name, :size, :max_people, :price, presence: true
  validates :status, inclusion: [true, false]
  belongs_to :guesthouse
  has_many :custom_price
end
