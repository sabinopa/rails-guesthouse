class Api::V1::GuesthousesController < Api::V1::ApiController

  def index
    guesthouses = Guesthouse.active
    if params[:search].present?
      guesthouses = guesthouses.brand_name_like(params[:search])
    end
    render status: 200, json: guesthouses.order(:brand_name).as_json(only: [:id, :brand_name])
  end

  def show
    guesthouse = Guesthouse.active.find(params[:id])
    
    render status: 200, json: { guesthouse: guesthouse.as_json({except: [:created_at, :updated_at, :registration_number, :corporate_name], methods: :available_rooms })}
  end

  def cities
    cities = Guesthouse.active.pluck(:city).uniq

    render status: 200, json: { cities: cities.as_json }
  end

  def by_city
    city = params[:city]
    guesthouses_by_city = Guesthouse.active.where(city: city).order(:brand_name)

    render status: 200, json: guesthouses_by_city.order(:city).as_json(except: [:created_at, :updated_at, :registration_number, :corporate_name] )
  end
end