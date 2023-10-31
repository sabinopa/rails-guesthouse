class Guesthouse < ApplicationRecord
  has_one :payment_method
  belongs_to :host
end
