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
    if Pet.update(params[:id], pet_params).valid?
      Pet.update(params[:id], pet_params)
      redirect_to "/pets/#{params[:id]}"
    else
      flash[:error] = "Incomplete Submission: Please fill out #{missing_fields(pet_params)} to complete your form."
      redirect_to request.referer
    end


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

  def pet_params
    params.permit(:image_url, :name, :description, :approximate_age, :sex)
  end
end
