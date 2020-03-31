class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    Pet.update(params[:id], update_pet_params)
    redirect_to "/pets/#{params[:id]}"
  end

  def destroy
    pet = Pet.find(params[:id])
    if pet.has_approved_application?
      flash[:error] = "Can not delete pet. Adoption currently pending."
    else
      pet.destroy_dependencies
      Pet.destroy(params[:id])
      favorites_list.remove_id(params[:id])
      session[:favorites_list] = favorites_list.pets
    end
    redirect_to "/pets"
  end

  private

  def update_pet_params
    params.permit(:image_url, :name, :description, :approximate_age, :sex)
  end
end
