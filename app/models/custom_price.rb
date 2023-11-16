class CustomPrice < ApplicationRecord
  belongs_to :room
  
  validates :start_date, :end_date, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validate :avoid_overlapping_dates
  validate :start_date_is_future
  validate :start_date_before_end_date

  private

  def start_date_is_future
    if start_date.present? && start_date.past?
      errors.add(:start_date, 'Ops, a data de início não pode ser passada')
    end
  end

  def start_date_before_end_date
    if start_date.present? && end_date.present? && start_date >= end_date
      errors.add(:start_date, 'Ops, a data de início deve ser anterior a data final.')
    end
  end

  def avoid_overlapping_dates
    return false if self.room.nil?
    new_period = Range.new(start_date, end_date)
    overlapping_custom_price = self.room.custom_price.any? do |custom|
      next if custom.id == self.id
      existing_period = Range.new(custom.start_date, custom.end_date)
      new_period.overlaps?(existing_period)
    end
    errors.add(:start_date, 'Ops, você já tem um preço especial cadastrado nessa data.') if overlapping_custom_price
  end
end

