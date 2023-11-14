class Booking < ApplicationRecord
  belongs_to :host
  belongs_to :guest
  belongs_to :room
end
