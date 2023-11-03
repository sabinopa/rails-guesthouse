class Guesthouse < ApplicationRecord
  enum status: { off: 0, on: 1 }

  validates :description, :brand_name, :corporate_name, :registration_number, :phone_number, :email, :address, :neighborhood, 
            :city, :state, :postal_code, :payment_method_id, :pet_friendly, :usage_policy, :checkin, :checkout, :status,
            presence: true

  has_one :payment_method
  belongs_to :host
end
