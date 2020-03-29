class PetsAdoptionAppsController < ApplicationController
  def index
    @pet = Pet.find(params[:pet_id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet.adoption_pending
    application = AdoptionApp.find(params[:app_id])
    pet.add_applicant_name(application.name)
    redirect_to "/pets/#{params[:pet_id]}"
  end
end
