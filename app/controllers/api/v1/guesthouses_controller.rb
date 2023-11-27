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
    available_rooms = guesthouse.rooms.where(status: :active)
    
    render status: 200, json: { guesthouse: guesthouse.as_json(except: [:created_at, :updated_at, :registration_number, :corporate_name]),
                                available_rooms: available_rooms.as_json(except: [:created_at, :updated_at]) }
  end
end