class Booking < ApplicationRecord
  belongs_to :host
  belongs_to :guest
  belongs_to :room

  validates :start_date, :end_date, :number_guests, presence: true
  validates :code, uniqueness: true
  validate :booking_date_is_future
  validate :start_date_before_end_date

  before_validation :generate_code, on: :create

  enum status: { pendent: 0,  booked: 2, ongoing: 4, done: 6, canceled: 8 }
  
  def total_price
    @custom_price = find_custom_price(start_date, end_date)
    days_stayed = (end_date - start_date).to_i
    return @custom_price * days_stayed if @custom_price.present?
    room.price * days_stayed
  end

  private 

  def find_custom_price(start_date, end_date)
    CustomPrice.where(room_id: self.room.id)
                .where('start_date <= ? AND end_date >= ?', start_date, end_date)
                .first
    @custom_price.price if @custom_price.present?
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def booking_date_is_future
    if self.start_date.present? && self.start_date <= Date.today
      self.errors.add(:start_date, 'Ops, a data de início não pode ser passada')
    end
  end

  def start_date_before_end_date
    if start_date.present? && end_date.present? && start_date >= end_date
      errors.add(:start_date, 'Ops, a data de início deve ser anterior a data final.')
    end
  end
end
