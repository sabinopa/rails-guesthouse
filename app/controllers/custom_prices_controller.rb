class CustomPricesController < ApplicationController
  before_action :authenticate_host!
  before_action :set_room, only: [:new, :create]
  before_action :set_guesthouse, only: [:new, :create]
  before_action :check_host

  def new
    @custom_price = CustomPrice.new
  end

  def create
    @custom_price = CustomPrice.new(custom_price_params)
    @custom_price.room = @room
    if @custom_price.save
      flash[:notice] = t('.success')
      redirect_to guesthouse_room_path(@room.guesthouse, @room)
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  private

  def custom_price_params
    params.require(:custom_price).permit(:start_date, :end_date, :price)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_guesthouse
    @guesthouse = Guesthouse.find(params[:guesthouse_id])
  end

  def check_host
    @room = Room.find(params[:room_id])
    @guesthouse = @room.guesthouse
  
    unless current_host == @guesthouse.host
      flash[:alert] = t('.error')
      redirect_to root_path
    end
  end
end