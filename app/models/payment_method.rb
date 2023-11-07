class PaymentMethod < ApplicationRecord
  validates_presence_of :method
  validates_uniqueness_of :method
end
