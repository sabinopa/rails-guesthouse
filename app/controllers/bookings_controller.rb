class BookingsController < ApplicationController 
  before_action :store_location, only: [:new]
  before_action :authenticate_guest!, only: [:new, :create, :show, :my_bookings, :guest_canceled]
  before_action :authenticate_host!, only: [:guesthouse_bookings, :host_control, :host_canceled, :ongoing_bookings, :checkin, :checkout, :checkout_register]
  before_action :set_room_and_guesthouse, only: [:new, :create, :show, :host_canceled, :guest_canceled, :host_control, :checkin, :checkout, :checkout_register]

  def new
    @booking = Booking.new(room: @room, start_date: params[:start_date], end_date: params[:end_date], number_guests: params[:number_guests])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.host = @guesthouse.host
    @total_price = total_price(params[:start_date], params[:end_date])
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
                                      .where(status: [:booked, :ongoing, :done])
  end
  
  def guesthouse_bookings
    @guesthouse = current_host.guesthouse
    @rooms = @guesthouse.rooms.where(status: :active)
    @bookings = Booking.joins(:room)
                        .where(rooms: { id: @rooms.pluck(:id) })
                        .where(status: :booked)
                        .order(:start_date)
                        .includes(room: { guesthouse: :payment_method })
  end

  def host_canceled
    @booking = Booking.find(params[:id]) 
    if @booking.host_cancellation_possibility?
      @booking.canceled!
      return redirect_to host_control_guesthouse_room_booking_path, notice: "Reserva #{@booking.code} cancelada com sucesso!" 
    else
      return redirect_to host_control_guesthouse_room_booking_path, alert: 'Não foi possível cancelar reserva!'
    end
  end

  def ongoing_bookings
    @guesthouse = current_host.guesthouse
    @rooms = @guesthouse.rooms.where(status: :active)
    @bookings = Booking.where(status: :ongoing)
  end
  
  def guest_canceled
    @booking = Booking.find(params[:id]) 
    if @booking.guest_cancellation_possibility?
      @booking.canceled!
      return redirect_to my_bookings_path, notice: "Reserva #{@booking.code} cancelada com sucesso!" 
    else
      return redirect_to my_bookings_path, alert: 'Não foi possível cancelar reserva!'
    end
  end

  def host_control
    @guesthouse = current_host.guesthouse
    @rooms = @guesthouse.rooms.where(status: :active)
    @booking = Booking.find(params[:id])
  end
  
  def checkin
    @booking = Booking.find(params[:id]) 
    if @booking.checkin_possibility?
      @booking.set_checkin
      return redirect_to host_control_guesthouse_room_booking_path, notice: "Reserva #{@booking.code} em andamento!" 
    else
      return redirect_to host_control_guesthouse_room_booking_path, alert: 'Não foi realizar o checkin!'
    end
  end

  def checkout
    @booking = Booking.find(params[:id]) 
    if @booking.status == 'ongoing'
      @booking.set_checkout
      return redirect_to host_control_guesthouse_room_booking_path, notice: "Reserva #{@booking.code} finalizada!" 
    else
      return redirect_to host_control_guesthouse_room_booking_path, alert: 'Não foi realizar o checkout!'
    end
  end

  def checkout_register 
    @booking = Booking.find(params[:id])
    @final_price = @booking.final_price
    @payment_methods = @guesthouse.payment_method_id
  end

  private

  def booking_params
    params.permit(:start_date, :end_date, :number_guests, :prices, :room_id)
  end

  def set_room_and_guesthouse
    @room = Room.find(params[:room_id])
    @guesthouse = @room.guesthouse
  end

  def store_location
    session[:guest_return_to] = request.original_url if request.get?
  end
end