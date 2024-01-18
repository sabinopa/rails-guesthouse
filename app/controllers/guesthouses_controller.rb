class GuesthousesController < ApplicationController
  before_action :authenticate_host!, except: [:show, :cities, :search, :guesthouse_reviews]
  before_action :set_guesthouse, only: [:show, :edit, :update, :active, :inactive, :guesthouse_reviews]
  before_action :check_host, only: [:edit, :update, :active, :inactive]

  def show 
    @available_rooms = @guesthouse.rooms.where(status: :active)
    @all_rooms = @guesthouse.rooms
    @reviews = @guesthouse.reviews.order(created_at: :desc)
    @newest_reviews = @reviews.first(3)
  end

  def new
    if current_host.guesthouse.present?
      flash[:alert] = t('.error')
      return redirect_to guesthouse_path(current_host.guesthouse)
    end
    @guesthouse = Guesthouse.new
  end
  
  def create
    @guesthouse = current_host.create_guesthouse(guesthouse_params)

    if @guesthouse.save
      flash[:notice] = t('.success', brand_name: @guesthouse.brand_name)
      redirect_to guesthouse_path(@guesthouse)
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end
      
  def edit
    if @guesthouse.host != current_host
      flash[:alert] = t('.error')
      redirect_to root_path
    end
  end

  def update
    if @guesthouse.update(guesthouse_params)
      flash[:notice] = t('.success', brand_name: @guesthouse.brand_name)
      redirect_to guesthouse_path(@guesthouse.id)
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  def search
    @query_params = params["query"]
    @guesthouses = Guesthouse.search(@query_params)
    if @guesthouses.empty?
      flash.now[:alert] = t('.error')
    end
  end

  def active
    @guesthouse.active!
    flash[:notice] = t('.success')
    redirect_to @guesthouse
  end

  def inactive
    @guesthouse.inactive!
    flash[:alert] = t('.success')
    redirect_to @guesthouse
  end

  def cities
    @city = params[:city]
    @guesthouses = Guesthouse.active.where(city: @city).order(:brand_name)
  end

  def guesthouse_reviews
    @reviews = @guesthouse.reviews.order(created_at: :desc)
    @average_rating = @guesthouse.reviews.pluck(:rating).sum.to_f / @guesthouse.reviews.count
  end

  private

  def set_guesthouse
    @guesthouse = Guesthouse.find(params[:id])
  end

  def guesthouse_params
    params.require(:guesthouse).permit(:description, :brand_name, :corporate_name, :registration_number, :phone_number,
                                      :email, :address, :neighborhood, :city, :state, :postal_code, :payment_method_id, 
                                      :pet_friendly, :usage_policy, :checkin, :checkout, :status)
  end

  def check_host 
    if current_host != @guesthouse.host
      flash[:alert] = t('.error')
      return redirect_to root_path
    end
  end
end
