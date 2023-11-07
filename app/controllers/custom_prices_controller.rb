class CustomPricesController < ApplicationController
  before_action :authenticate_host!
  before_action :set_guesthouse
  before_action :set_room

  def new
    @custom_price = CustomPrice.new(custom_price_params)
  end

  def create
    @custom_price = CustomPrice.create(custom_price_params)
    @custom_price.room = @room
    if @custom_price.save
      redirect_to guesthouse_room_path(@room.guesthouse, @room), notice: 'Novo preço cadastrado com sucesso!'
    else
      flash.now[:alert] = 'Não foi possível cadastrar preço personalizado.'
      render :new
    end
  end

  def edit
  end

  def update
    if @custom_price.update(custom_price_params)
      redirect_to guesthouse_room_custo_price_path(guesthouse_id: @guesthouse, id: @room.id), 
      notice: 'Preço personalizado cadastrado com sucesso!'
    else
      flash.now[:alert] = 'Não foi possível cadastrar preço personalizado.'
      render :edit
    end
  end

  private

  def set_price_params
    @custom_price = CustomPrice.find(params[:id])
  end

  def custom_price_params
    params.require(:custom_price).permit(:start_date, :end_date, :price)
  end

  def set_guesthouse
    @guesthouse = Guesthouse.find(params[:id])
  end

  def set_room
    @room = @guesthouse.rooms.find(params[:id])
  end
end