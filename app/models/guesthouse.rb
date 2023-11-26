class Guesthouse < ApplicationRecord
  belongs_to :payment_method
  belongs_to :host
  has_many :rooms
  has_many :bookings, through: :rooms
  has_many :reviews, through: :bookings
  
  validates :description, :brand_name, :corporate_name, :registration_number, 
            :phone_number, :email, :address, :neighborhood, :city, :state, 
            :postal_code, :payment_method_id, :usage_policy, :checkin, 
            :checkout, presence: true
  validates :pet_friendly, inclusion: [true, false]
  validate :host_has_guesthouse, on: :create

  enum status: { inactive: 0, active: 1 }

  scope :brand_name_like, -> (query) { where("brand_name LIKE ?", "%#{query}%") }
  scope :neighborhood_like, -> (query) { where("neighborhood LIKE ?", "%#{query}%") }
  scope :city_like, -> (query) { where("city LIKE ?", "%#{query}%") }

  def self.search(query_params)
    active.brand_name_like(query_params)
          .or(neighborhood_like(query_params)
          .or(city_like(query_params)))
  end

  private 

  def host_has_guesthouse
    if Guesthouse.exists?(host: self.host)
      errors.add(:host, 'Ops, você já tem uma pousada cadastrada!')
    end
  end
end