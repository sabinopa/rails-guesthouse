class CustomPrice < ApplicationRecord
  validates :start_date, :end_date, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validate :start_date_before_end_date
  validate :avoid_overlapping_dates

  belongs_to :room

  private

  def start_date_before_end_date
    if start_date.present? && end_date.present? && start_date >= end_date
      errors.add(:start_date, 'Ops, a data de início deve ser anterior a data final.')
    end
  end

  def avoid_overlapping_dates
    first_period = Range.new(start_date, end_date)
    CustomPrice.all.each do |custom|
      second_period = Range.new(custom.start_date, custom.end_date)
      errors.add(:start_date, 'Ops, você já tem um preço especial cadastrado nessa data.') if first_period.overlaps?second_period
    end
  end 
end