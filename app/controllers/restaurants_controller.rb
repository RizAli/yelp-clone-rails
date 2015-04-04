class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to '/restaurants'
    else
      render 'new'
    end
  end

  def show
    @restaurant = restaurant_selector
  end

  def edit
    @restaurant = restaurant_selector
  end

  def update
    @restaurant = restaurant_selector
    @restaurant.update(restaurant_params)
    redirect_to '/restaurants'
  end

  def destroy
    @restaurant = restaurant_selector
    @restaurant.destroy
    flash[:notice] = "Restaurant deleted successfully"
    redirect_to '/restaurants'
  end

  #### Helper methods

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  def restaurant_selector
    Restaurant.find(params[:id])
  end

end
