class BookingsController < ApplicationController 
  def new
    @room = Room.find(params[:room_id])
    @booking = @room.bookings.build
    @guesthouse = @room.guesthouse
  end

  def create
    @booking = @room.bookings.build(booking_params)

    if @booking.save
      redirect_to @booking, notice: 'Reserva finalizada com sucesso!'
    else
      flash.now[:alert] = 'Não foi finalizar a reserva'
      render :new
    end
  end
  
  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :number_guests)
  end
end
