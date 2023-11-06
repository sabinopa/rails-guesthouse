class RoomsController < ApplicationController
  before_action :authenticate_host!
  before_action :set_room, only: [:show, :edit, :update]
  before_action :set_room_and_check_host, only: [:new, :create, :edit, :update]

  def show
    @guesthouse = current_host.guesthouse
  end

  def new
    @guesthouse = current_host.guesthouse
    @room = Room.new
  end

  def create
    @guesthouse = current_host.guesthouse
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
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:description, :name, :size, :max_people, :price, :bathroom,
                                :balcony, :air_conditioner, :tv)
  end

  def set_room_and_check_host
    if Room.find(params[:id]).guesthouse.host != @guesthouse.host
      return redirect_to root_path, notice: 'Ops, você não é o anfitrião dessa pousada.'
    end
  end
end