class RoomsController < ApplicationController
  before_action :authenticate_host!

  def show
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_host.create_room(room_params)

    if @room.save
      redirect_to room_path, notice: "Quarto #{@room.name}: Criado com sucesso!"
    else
      flash.now[:notice] = 'Quarto não cadastrado.'
    end
  end

  def edit
    if @room.guesthouse.host != current_host
      redirect_to root_path, notice: 'Você não pode editar esse quarto'
    end
  end

  def update
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:description, :name, :size, :max_people, :price, :bathroom,
                                :balcony, :air_conditioner, :tv)
  end
end