class CustomPricesController < ApplicationController
  before_action :set_room, only: [:new, :create, :edit, :update]

  def new
    @custom_price = CustomPrice.new
  end

  def create
    @custom_price = CustomPrice.new(custom_price_params)
    @custom_price.room = @room
    if @custom_price.save
      redirect_to guesthouse_room_path(@room.guesthouse, @room), notice: 'Novo preço cadastrado com sucesso!'
    else
      flash.now[:alert] = 'Não foi possível cadastrar preço personalizado.'
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
end