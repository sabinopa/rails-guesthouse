class BookingsController < ApplicationController 
  before_action :authenticate_guest!, only: [:booked, :my_bookings]
  before_action :set_room_and_guesthouse, except: [:validation, :booked, :my_bookings]

  def new
    @guest = current_guest
    @booking = Booking.new(room: @room, start_date: params[:start_date], end_date: params[:end_date], number_guests: params[:number_guests])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.host = @guesthouse.host
    @booking.guest = current_guest

    if @booking.save
      redirect_to guesthouse_room_booking_path(@guesthouse, @room, @booking)
    else
      flash.now[:alert] = 'Não foi possível reservar o quarto.'
      render :new
    end
  end

  def show
    #TO-DO
  end

  def my_bookings
    @bookings = current_guest.bookings.includes(room: { guesthouse: :payment_method })  
  end
  
  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :number_guests, :price, :room_id)
  end

  def set_room_and_guesthouse
    @room = Room.find(params[:room_id])
    @guesthouse = @room.guesthouse
  end
end