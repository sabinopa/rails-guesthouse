class Room < ApplicationRecord
  belongs_to :guesthouse
  has_many :custom_prices
  has_many :bookings

  validates :description, :name, :size, :max_people, :price, presence: true
  
  enum status: { inactive: 0, active: 1 }

  def has_availability?(start_date, end_date)
    new_period = Range.new(start_date.to_date, end_date.to_date)
    bookings.where(status: [:booked, :ongoing]).each do |booking|
      existing_period = Range.new(booking.start_date, booking.end_date)
      return false if new_period.overlaps?(existing_period)
    end
    true
  end

  def total_price(start_date, end_date)
    total = 0
    (start_date.to_date..end_date.to_date).each do |date|
      next if date == start_date.to_date
      custom_price = find_custom_price(date)
      total += custom_price ? custom_price.price.to_f : price.to_f
    end
    total
  end
  
  private 

  def find_custom_price(date)
    custom_prices.where('? BETWEEN start_date AND end_date', date).first
  end
end
