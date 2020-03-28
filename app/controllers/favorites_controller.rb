class FavoritesController < ApplicationController
  def index
    @favorite_pets = Pet.where(id: favorites_list.pets)
  end

  def destroy
    favorites_list.remove_id(params[:pet_id])
    session[:favorites_list] = favorites_list.pets
    flash[:notice] = "Successfully Removed Pet from Favorites"
    redirect_to "/pets/#{params[:pet_id]}"
  end
end
