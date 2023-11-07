class Room < ApplicationRecord
  validates :description, :name, :size, :max_people, presence: true
  validates :status, inclusion: [true, false]
  belongs_to :guesthouse
end
