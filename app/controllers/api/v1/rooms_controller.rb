class Api::V1::RoomsController < Api::V1::ApiController

  def availability
    unless params[:start_date].present? && params[:end_date].present? && params[:number_guests].present?
      return render status: 412, json: { errors: availability.errors.full_messages }
    end

    @room = Room.find(params[:id])
    return render status: 404, json: { error: 'Quarto não encontrado.' } unless @room
    if room_is_available?(params[:start_date], params[:end_date], params[:number_guests])
      total_price = @room.total_price(params[:start_date], params[:end_date])
      render status: 200, json: { available: true, total_price: total_price }
    else 
      render status: 200, json: { available: false, message: 'Quarto não disponível para reserva ou número de hóspedes excede a capacidade.' } 
    end
  end

  private

  def room_is_available?(start_date, end_date, number_guests)
    @room.has_availability?(start_date, end_date) && number_guests.to_i <= @room.max_people.to_i  
  end
end

