class PetsAdoptionAppsController < ApplicationController
  def index
    @pet = Pet.find(params[:pet_id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet.make_unadoptable
    application = AdoptionApp.find(params[:app_id])
    pet.add_applicant_info(application.name, application.id)
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def delete
    pet = Pet.find(params[:pet_id])
    pet.make_adoptable
    pet.delete_applicant_info
    redirect_to request.referer
  end
end
