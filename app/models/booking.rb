class Booking < ApplicationRecord
  belongs_to :host
  belongs_to :guest
  belongs_to :room

  validates :start_date, :end_date, :number_guests, presence: true
  validates :code, uniqueness: true
  
  before_validation :generate_code, on: :create

  enum status: { booked: 2, ongoing: 4, done: 6, canceled: 8 }

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
