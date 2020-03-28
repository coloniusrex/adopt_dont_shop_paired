class PetsFavoritesController < ApplicationController
  def update
    favorites_list.add_pet(params[:pet_id])
    session[:favorites_list] = favorites_list.pets
    flash[:notice] = 'You successfully added a pet to your favorites list!'
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def destroy
    favorites_list.remove_id(params[:pet_id])
    session[:favorites_list] = favorites_list.pets
    flash[:notice] = "Successfully Removed Pet from Favorites"
    redirect_to request.referer
  end
end
