class GuesthousesController < ApplicationController
  before_action :authenticate_host!, except: [:show, :cities, :search]
  before_action :set_guesthouse, only: [:show, :edit, :update, :active, :inactive]
  before_action :check_host, only: [:edit, :update, :active, :inactive]

  def show 
    @available_rooms = @guesthouse.rooms.where(status: :active)
    @all_rooms = @guesthouse.rooms
  end

  def new
    if current_host.guesthouse.present?
      return redirect_to guesthouse_path(current_host.guesthouse), notice: 'Ops, você já tem uma pousada cadastrada!'
    end
    @guesthouse = Guesthouse.new
  end
  
  def create
    @guesthouse = current_host.create_guesthouse(guesthouse_params)

    if @guesthouse.save
      redirect_to guesthouse_path(@guesthouse), notice: "#{@guesthouse.brand_name}: Criado com sucesso!"
    else
      flash.now[:alert] = 'Pousada não cadastrada.'
      render :new
    end
  end
      
  def edit
    if @guesthouse.host != current_host
      redirect_to root_path, alert: 'Você não pode editar essa pousada!'
    end
  end

  def update
    if @guesthouse.update(guesthouse_params)
      redirect_to guesthouse_path(@guesthouse.id), notice: "#{@guesthouse.brand_name}: Atualizado com sucesso!"
    else
      flash.now[:alert] = 'Não foi possível atualizar a pousada.'
      render :new
    end
  end

  def search
    @query_params = params["query"]
    @guesthouses = Guesthouse.search(@query_params)
    if @guesthouses.empty?
      flash.now[:alert] = 'Nenhuma pousada encontrada!'
    end
  end

  def active
    @guesthouse.active!
    redirect_to @guesthouse, notice: 'Sua pousada está ativa!'
  end

  def inactive
    @guesthouse.inactive!
    redirect_to @guesthouse, notice: 'Sua pousada está inativa!'
  end

  def cities
    @city = params[:city]
    @guesthouses = Guesthouse.active.where(city: @city).order(:brand_name)
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
  
  def check_guesthouse_presence
    if current_host.guesthouse
      return redirect_to root_path, alert: 'Ops, você já tem uma pousada cadastrada!'
    end
  end

  def check_host
    if current_host.guesthouse != @guesthouse
      return redirect_to root_path, alert: 'Ops, você não é o anfitrião dessa pousada.'
    end
  end
end