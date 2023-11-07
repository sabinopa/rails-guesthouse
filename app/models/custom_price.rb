class CustomPrice < ApplicationRecord
  validates :start_date, :end_date, :price, presence: true
  belongs_to :room
end
