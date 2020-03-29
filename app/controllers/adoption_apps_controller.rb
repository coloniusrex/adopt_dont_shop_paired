class AdoptionAppsController < ApplicationController
  def new
    @favorite_pets = Pet.where(id: favorites_list.pets)
  end

  def create
    adoption_app = AdoptionApp.new(adoption_app_params)
    if adoption_app.save
      process_application_with_pets(adoption_app, params[:selected_pet])
      flash[:notice] = "Adoption Application Successfully Submitted"
      redirect_to "/favorites"
    else
      flash[:error] = "Missing information! Please fill out all fields before clicking submit."
      redirect_to request.referer
    end
  end

  def show
    @pet_app = AdoptionApp.find(params[:id])
  end

  private

  def adoption_app_params
    params.permit(:name, :address, :city, :state,
                  :zip, :phone_number, :description)
  end

  def process_application_with_pets(application, pet_ids)
    application.process(pet_ids)
    favorites_list.remove_multiple(pet_ids)
    session[:favorites_list] = favorites_list.pets
  end
end
