class Room < ApplicationRecord
  validates :description, :name, :size, :max_people, :price,  presence: true
  belongs_to :guesthouse
end
