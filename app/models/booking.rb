class Booking < ApplicationRecord
  belongs_to :host
  belongs_to :guest
  belongs_to :room

  validates :start_date, :end_date, :number_guests, presence: true
  validates :code, uniqueness: true
  
  before_validation :generate_code, on: :create

  enum status: { booked: 0, ongoing: 2, done: 4, canceled: 6 }

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def guest_cancellation_possibility?
    days_until_checkin = (self.start_date.to_date - Date.today).to_i
    days_until_checkin >= 7 ? true : false
  end

  def host_cancellation_possibility?
    days_after_start_date = (Date.today - self.start_date.to_date).to_i
    days_after_start_date >= 2 ? true : false
  end

  def checkin_possibility?
    return false if self.status == 'ongoing'
    (self.start_date.to_date..self.end_date.to_date).include?(Date.today)
  end

  def set_checkin
    if checkin_possibility?
      self.checkin_time = DateTime.now
      self.update(status: :ongoing)
    end
  end
end
