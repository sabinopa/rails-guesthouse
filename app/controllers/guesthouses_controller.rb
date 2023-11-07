class GuesthousesController < ApplicationController
  before_action :authenticate_host!, except: [:show]
  before_action :set_guesthouse, only: [:show, :edit, :update]

  def show 
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
      flash.now[:notice] = 'Pousada não cadastrada.'
      render :new
    end
  end
      
  def edit
    if @guesthouse.host != current_host
      redirect_to root_path, notice: 'Você não pode editar essa pousada!'
    end
  end

  def update
    if @guesthouse.update(guesthouse_params)
      redirect_to guesthouse_path(@guesthouse.id), notice: "#{@guesthouse.brand_name}: Atualizado com sucesso!"
    else
      flash.now[:notice] = 'Não foi possível atualizar a pousada.'
      render :new
    end
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
end