class Api::V1::GuesthousesController < Api::V1::ApiController

  def show
    p 'oiiii estou passando aqui!!!!'
    guesthouse = Guesthouse.find(params[:id])
    render status: 200, json: guesthouse.as_json(except: [:created_at, :updated_at])
  end

  def index
    guesthouses = Guesthouse.all.order(:brand_name)
    render status: 200, json: guesthouses
  end