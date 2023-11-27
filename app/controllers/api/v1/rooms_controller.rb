class Api::V1::RoomsController < Api::V1::ApiController
  
  def availability
    errors = validate_required_params
    if errors.any?
      return render status: 412, json: { errors: errors }
    end

    @room = Room.find(params[:id])
    return render status: 404, json: { error: 'Quarto não encontrado.' } unless @room

    if @room.has_availability?(params[:start_date], params[:end_date], params[:number_guests])
      total_price = @room.total_price(params[:start_date], params[:end_date])
      render status: 200, json: { available: true, total_price: total_price }
    else 
      render status: 200, json: { available: false, message: 'Quarto não disponível para reserva ou número de hóspedes excede a capacidade.' } 
    end
  end

  private

  def validate_required_params
    errors = []
    errors << 'Data de início não pode ficar em branco' unless params[:start_date].present?
    errors << 'Data de término não pode ficar em branco' unless params[:end_date].present?
    errors << 'Número de hóspedes não pode ficar em branco' unless params[:number_guests].present?
    errors
  end
end


