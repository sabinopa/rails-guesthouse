class RoomsController < ApplicationController
  before_action :authenticate_host!, except: [:index, :show, :availability]
  before_action :set_guesthouse, except: [:show, :availability]
  before_action :set_room, except: [:new, :create, :index]
  before_action :check_host, only: [:edit, :update]

  def index
    if current_host.present?
      @rooms = @guesthouse.rooms
    else
      @rooms = @guesthouse.rooms.where(status: :active)
    end
  end

  def show
    @guesthouse = Guesthouse.find(params[:guesthouse_id])
    @custom_prices = CustomPrice.all.where(room_id: @room.id)
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.guesthouse = @guesthouse

    if @room.save
      redirect_to guesthouse_rooms_path, notice: "Quarto #{@room.name}: Criado com sucesso!"
    else
      flash.now[:alert] = 'Quarto não cadastrado.'
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to guesthouse_room_path(guesthouse_id: @guesthouse, id: @room.id), notice: "#{@room.name}: Atualizado com sucesso!"
    else
      flash.now[:alert] = 'Não foi possível atualizar o quarto.'
      render :new
    end 
  end

  def active
    @room.active!
    redirect_to guesthouse_room_path(guesthouse_id: @guesthouse, id: @room.id), notice: "Quarto ativo!"
  end

  def inactive
    @room.inactive!
    redirect_to guesthouse_room_path(guesthouse_id: @guesthouse, id: @room.id), notice: "Quarto inativo!"
  end

  def availability
    @guesthouse = @room.guesthouse

    if params[:start_date].blank? || params[:end_date].blank? || params[:number_guests].blank?
      flash[:alert] = 'Por favor, preencha todos os campos.'
      return redirect_to guesthouse_room_path(@guesthouse, @room)
    end

    if @room.has_availability?(params[:start_date], params[:end_date], params[:number_guests])
      flash[:notice] = 'Quarto disponível, você pode finalizar a sua reserva.'
      return redirect_to new_guesthouse_room_booking_path(guesthouse_id: @guesthouse.id , room_id: @room.id, start_date: params[:start_date], end_date: params[:end_date], number_guests: params[:number_guests])
    else 
      flash[:alert] = 'Quarto não disponível para reserva ou número de hóspedes excede a capacidade.'
      return redirect_to guesthouse_room_path(@guesthouse, @room)
    end
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:description, :name, :size, :max_people, :price, :bathroom,
                                :balcony, :air_conditioner, :tv, :wardrobe, :safe, :accessibility, :status)
  end

  def set_guesthouse
    @guesthouse = current_host.guesthouse
  end

  def check_host
    if @room.guesthouse.host != @guesthouse.host
      return redirect_to root_path, alert: 'Desculpe, mas você não tem permissão para realizar essa ação.'
    end
  end
end