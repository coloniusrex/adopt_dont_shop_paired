class PetsAdoptionAppsController < ApplicationController
  def index
    @pet = Pet.find(params[:pet_id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet.make_unadoptable
    application = pet.adoption_apps.where(id:params[:app_id]).take
    application.approve_for(pet.id)
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def delete
    pet = Pet.find(params[:pet_id])
    pet.make_adoptable
    application = pet.adoption_apps.where(id:params[:app_id]).take
    application.unapprove_for(pet.id)
    redirect_to request.referer
  end
end
