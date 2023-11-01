class Guesthouse < ApplicationRecord
  #enum status: { off: 0, on: 1 }

  has_one :payment_method
  belongs_to :host
end
