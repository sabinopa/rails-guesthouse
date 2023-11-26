class ReviewsController < ApplicationController
  before_action :authenticate_host!, only: [:host_reviews, :answer, :create_answer]
  before_action :authenticate_guest!, only: [:new, :create]
  before_action :set_booking
  before_action :check_guest, only: [:new, :create]
  before_action :check_host, only: [:host_reviews, :answer, :create_answer]
  before_action :only_after_checkout

  def new
    @review = Review.new(booking: @booking)
  end

  def create
    review_params = params.require(:review).permit(:rating, :comment)
    @review = @booking.create_review(review_params)
    
    if @review.save
      redirect_to my_bookings_path, notice: 'Avaliação salva com sucesso!'
    else 
      flash.now[:alert] = 'Não foi possível salvar a sua avaliação.'
      render :new
    end
  end

  def host_reviews
    @reviews = current_host.guesthouse.reviews
  end

  def answer
    @review = Review.find(params[:id])
  end

  def create_answer
    @review = Review.find(params[:id])

    if @review.save
      redirect_to host_reviews_guesthouse_room_booking_review_path, notice: 'Resposta salva com sucesso!'
    else
      flash.now[:alert] = 'Resposta não cadastrada.'
      render :answer
    end
  end

  private

  def set_booking
    @booking = Booking.find_by(params[:booking_id])
    if @booking.present?
      @room = @booking.room
      @guesthouse = @booking.room.guesthouse
    end
  end

  def only_after_checkout
    if @booking.status != 'done'
      redirect_to my_bookings_path, alert: 'Desculpe, mas você não tem permissão para realizar essa ação.'
    end
  end
  

  def check_host
    unless @review.guesthouse.host == current_host
      redirect_to root_path, alert: 'Desculpe, mas você não tem permissão para realizar essa ação.'
    end
  end

  def check_guest
    if @booking.guest != current_guest
      redirect_to my_bookings_path, alert: 'Desculpe, mas você não tem permissão para realizar essa ação.'
    end
  end
end