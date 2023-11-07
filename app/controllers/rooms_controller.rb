class RoomsController < ApplicationController
  before_action :authenticate_host!, except: [:index, :show]
  before_action :set_guesthouse
  before_action :set_room, only: [:show, :edit, :update]
  before_action :check_host, only: [:new, :create, :edit, :update]

  def index
    if current_host.present?
      @rooms = @guesthouse.rooms
    else
      @rooms = @guesthouse.rooms.where(status: true)
    end
  end

  def show
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
      flash.now[:notice] = 'Quarto não cadastrado.'
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to guesthouse_room_path(guesthouse_id: @guesthouse, id: @room.id), notice: "#{@room.name}: Atualizado com sucesso!"
    else
      flash.now[:notice] = 'Não foi possível atualizar o quarto.'
      render :new
    end 
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:description, :name, :size, :max_people, :price, :bathroom,
                                :balcony, :air_conditioner, :tv, :status)
  end

  def check_host
    if @guesthouse.host != current_host
      return redirect_to root_path, notice: 'Ops, você não é o anfitrião dessa pousada.'
    end
  end

  def set_guesthouse
    @guesthouse = Guesthouse.find(params[:guesthouse_id])
  end
end