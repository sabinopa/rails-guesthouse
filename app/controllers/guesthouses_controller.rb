class GuesthousesController < ApplicationController
  before_action :authenticate_host!
  before_action :set_guesthouse, only: [:show, :edit, :update]

  def show 
  end
  
  def new
    @guesthouse = Guesthouse.new
  end
  
  def create
    @guesthouse = current_host.create_guesthouse(guesthouse_params)

    if @guesthouse.save
      redirect_to guesthouse_path(@guesthouse), notice: "#{@guesthouse.brand_name}: Criada com sucesso!"
    else
      flash.now[:notice] = 'Pousada não cadastrada.'
      render :new
    end
  end
      
  def edit
  end

  def update   
    if @guesthouse.update(guesthouse_params)
      redirect_to guesthouse_path, notice: "#{@guesthouse.brand_name}: Atualizado com sucesso!"
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