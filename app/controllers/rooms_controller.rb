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
      flash[:notice] = t('.success', room_name: @room.name)
      redirect_to guesthouse_rooms_path
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      flash[:notice] = t('.success', room_name: @room.name)
      redirect_to guesthouse_room_path(guesthouse_id: @guesthouse, id: @room.id)
    else
      flash.now[:alert] = t('.error')
      render :new
    end 
  end

  def active
    @room.active!
    flash[:notice] = t('.success')
    redirect_to guesthouse_room_path(guesthouse_id: @guesthouse, id: @room.id)
  end

  def inactive
    @room.inactive!
    flash[:alert] = t('.success')
    redirect_to guesthouse_room_path(guesthouse_id: @guesthouse, id: @room.id)
  end

  def availability
    @guesthouse = @room.guesthouse

    if params[:start_date].blank? || params[:end_date].blank? || params[:number_guests].blank?
      flash[:alert] = t('.missing')
      return redirect_to guesthouse_room_path(@guesthouse, @room)
    end

    if @room.has_availability?(params[:start_date], params[:end_date], params[:number_guests])
      flash[:notice] = t('.success')
      return redirect_to new_guesthouse_room_booking_path(guesthouse_id: @guesthouse.id , room_id: @room.id, start_date: params[:start_date], end_date: params[:end_date], number_guests: params[:number_guests])
    else 
      flash[:alert] = t('.error')
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
      flash[:alert] = t('.error')
      return redirect_to root_path
    end
  end
end