class Room < ApplicationRecord
  belongs_to :guesthouse
  has_many :custom_price
  has_many :bookings

  validates :description, :name, :size, :max_people, :price, presence: true
  
  enum status: { inactive: 0, active: 1 }

  def has_availability?(start_date, end_date)
    new_period = Range.new(start_date, end_date)
    bookings.none? do |booking|
      existing_period = Range.new(booking.start_date, booking.end_date)
      new_period.overlaps?(existing_period)
    end
  end
end
