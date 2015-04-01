class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    Restaurant.create(restaurant_params)
    redirect_to '/restaurants'
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
    @restaurant.delete
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
