class SearchesController < ApplicationController
  def show
      @search = Search.find(params[:id])
  end 

  def new 
      @search = Search.new

      @bathroom = Room.distinct.pluck(:bathroom)
      @balcony = Room.distinct.pluck(:balcony)
      @air_conditioner = Room.distinct.pluck(:air_conditioner)
      @tv = Room.distinct.pluck(:tv)
      @wardrobe = Room.distinct.pluck(:wardrobe)
      @safe = Room.distinct.pluck(:safe)
      @accessibility = Room.distinct.pluck(:accessibility)
  end

  def create
      @search = Search.create(search_params)
      redirect_to @search
  end 

  private

  def search_params
      params.require(:search).permit(:bathroom, :balcony, :air_conditioner, :tv, :wardrobe, :safe, :accessibility)
  end 
end