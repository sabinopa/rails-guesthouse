class BookingsController < ApplicationController 
  before_action :authenticate_guest!, only: [:create, :show, :my_bookings]
  before_action :set_room_and_guesthouse, except: [:validation, :my_bookings]

  def new
    @guest = current_guest
    @booking = Booking.new(room: @room, start_date: params[:start_date], end_date: params[:end_date], number_guests: params[:number_guests])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.host = @guesthouse.host
    @booking.guest = current_guest
    @total_price = @room.total_price(booking_params[:start_date], booking_params[:end_date])
    @booking.prices = @total_price
    
    if @booking.save
      return redirect_to guesthouse_room_booking_path(@guesthouse, @room, @booking)
    else
      flash[:alert] = 'Não foi possível reservar o quarto.'
      return redirect_to guesthouse_room_path(@guesthouse, @room)
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @total_price = @booking.room.total_price(@booking.start_date, @booking.end_date)
  end

  def my_bookings
    @bookings = current_guest.bookings.includes(room: { guesthouse: :payment_method })
  end
  
  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :number_guests, :prices, :room_id)
  end

  def set_room_and_guesthouse
    @room = Room.find(params[:room_id])
    @guesthouse = @room.guesthouse
  end
end