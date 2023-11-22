class Booking < ApplicationRecord
  belongs_to :host
  belongs_to :guest
  belongs_to :room
  has_one :review

  validates :start_date, :end_date, :number_guests, presence: true
  validates :code, uniqueness: true
  
  before_validation :generate_code, on: :create

  enum status: { booked: 0, ongoing: 2, done: 4, canceled: 6 }

  def guest_cancellation_possibility?
    days_until_checkin = (self.start_date.to_date - Date.today).to_i
    days_until_checkin >= 7 && self.booked? ? true : false
  end

  def host_cancellation_possibility?
    days_after_start_date = (Date.today - self.start_date.to_date).to_i 
    days_after_start_date >= 2 && self.booked? ? true : false
  end

  def checkin_possibility?
    return false if self.status == 'ongoing'
    (self.start_date.to_date..self.end_date.to_date).include?(Date.today) && self.booked?
  end

  def set_checkin
    if checkin_possibility?
      self.checkin_time = Time.zone.now 
      self.update(status: :ongoing)
    end
  end

  def total_price(start_date, end_date)
    total = 0
    (start_date.to_date..end_date.to_date).each do |date|
      next if date == start_date.to_date
      custom_price = find_custom_price(date)
      total += custom_price ? custom_price.price.to_f : self.room.price.to_f
    end
    total
  end
  
  def final_price
    current_time = Time.zone.now.strftime("%H:%M")
    guesthouse_checkout = self.room.guesthouse.checkout.strftime("%H:%M")
    guest_checkin = self.checkin_time.to_date
    guest_checkout = Time.zone.now
    guest_checkout += 1 if current_time > guesthouse_checkout
    guest_checkout -= 1 if guest_checkout < end_date.to_date
    
    total_price(guest_checkin, guest_checkout)
  end
  
  def set_checkout
    self.checkout_time = Time.zone.now
    self.update(status: :done)
  end
  
  private
  
  def find_custom_price(date)
    self.room.custom_prices.where('? BETWEEN start_date AND end_date', date).first
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
