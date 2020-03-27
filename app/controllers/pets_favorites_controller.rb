class PetsFavoritesController < ApplicationController
  def update
    validate = !!favorites_list.add_pet(params[:pet_id])
    session[:favorites_list] = favorites_list.pets
    flash_handler(validate)
    redirect_to "/pets/#{params[:pet_id]}"
  end

  private

  def flash_handler(boolean)
    if boolean
      flash[:notice] = 'You successfully added a pet to your favorites list!'
    else
      flash[:error] = 'You already have this pet in your favorites list!'
    end
  end
end
