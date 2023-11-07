class Guesthouse < ApplicationRecord
  validates :description, :brand_name, :corporate_name, :registration_number, 
            :phone_number, :email, :address, :neighborhood, :city, :state, 
            :postal_code, :payment_method_id, :usage_policy, :checkin, 
            :checkout, presence: true
  validates :status, inclusion: [true, false]
  validates :pet_friendly, inclusion: [true, false]
  validate :host_has_guesthouse, on: :create

  belongs_to :payment_method
  belongs_to :host
  has_many :rooms
  
  private 

  def host_has_guesthouse
    if Guesthouse.exists?(host: self.host)
      errors.add(:host, 'Ops, você já tem uma pousada cadastrada!')
    end
  end
end