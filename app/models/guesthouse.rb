class Guesthouse < ApplicationRecord
  validates :description, :brand_name, :corporate_name, :registration_number, :phone_number, :email, :address, :neighborhood, 
  :city, :state, :postal_code, :payment_method_id, :usage_policy, :checkin, :checkout, :status, presence: true

  validate :host_has_guesthouse, on: :create

  belongs_to :host
  has_many :rooms
  has_one :payment_method
  
  private 

  def host_has_guesthouse
    if Guesthouse.exists?(host: self.host)
      errors.add(:host, 'Ops, você já tem uma pousada cadastrada!')
    end
  end
end