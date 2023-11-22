class ReviewsController < ApplicationController
  before_action :set_review

  def new
    @review = Review.new(booking: @booking)
  end

  def create
    review_params = params.require(:review).permit(:rating, :comment)
    @review = @booking.create_review(review_params)
    
    if @review.save
      redirect_to my_bookings_path, notice: 'Avaliação salva com sucesso!'
    else 
      flash.now[:alert] = 'Não foi possível salvar a sua avaliação'
      render :new
    end


  end

  private

  def set_review
    @booking = Booking.find(params[:booking_id])
    if @booking.present?
      @room = @booking.room
      @guesthouse = @booking.room.guesthouse
    end
  end
end