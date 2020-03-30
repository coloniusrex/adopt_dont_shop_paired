class PetsAdoptionAppsController < ApplicationController
  def index
    @pet = Pet.find(params[:pet_id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet.make_unadoptable
    pet_adoption_app = PetAdoptionApp.where(adoption_app_id:params[:app_id], pet_id: params[:pet_id])
    pet_adoption_app.update(approved:true)
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def delete
    pet = Pet.find(params[:pet_id])
    pet.make_adoptable
    redirect_to request.referer
  end
end
