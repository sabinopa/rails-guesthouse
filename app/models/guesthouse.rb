class Guesthouse < ApplicationRecord
  validates :description, :brand_name, :corporate_name, :registration_number, 
            :phone_number, :email, :address, :neighborhood, :city, :state, 
            :postal_code, :payment_method_id, :usage_policy, :checkin, 
            :checkout, presence: true
  validates :pet_friendly, inclusion: [true, false]
  validate :host_has_guesthouse, on: :create

  enum status: { inactive: 0, active: 1 }

  belongs_to :payment_method
  belongs_to :host
  has_many :rooms

  scope :brand_name_like, -> (query) { where("brand_name LIKE ?", query) }
  scope :neighborhood_like, -> (query) { where("neighborhood LIKE ?", query) }
  scope :city_like, -> (query) { where("city LIKE ?", query) }
  scope :pet_friendly_like, -> (query) { where("pet_friendly LIKE ?", query) }
  scope :bathroom_like, -> (query) { where("bathroom LIKE ?", query) }
  scope :balcony_like, -> (query) { where("balcony LIKE ?", query) }
  scope :air_conditioner_like, -> (query) { where("air_conditioner LIKE ?", query) }
  scope :tv_like, -> (query) { where("tv LIKE ?", query) }
  scope :wardrobe_like, -> (query) { where("wardrobre LIKE ?", query) }
  scope :safe_like, -> (query) { where("safe LIKE ?", query) }
  scope :accessibility_like, -> (query) { where("accessibility LIKE ?", query) }

  def self.search(query_params)
    active.brand_name_like(query_params)
          .or(neighborhood_like(query_params)
          .or(city_like(query_params)
          .or(pet_friendly_like(query_params)
          .or(bathroom_like(query_params)
          .or(balcony_like(query_params)
          .or(air_conditioner_like(query_params)
          .or(tv_like(query_params)
          .or(wardrobe_like(query_params)
          .or(safe_like(query_params)
          .or(accessibility_like(query_params)))))))))))
          .order(:brand_name)
  end

  private 

  def host_has_guesthouse
    if Guesthouse.exists?(host: self.host)
      errors.add(:host, 'Ops, você já tem uma pousada cadastrada!')
    end
  end
end