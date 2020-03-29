class AdoptionAppsController < ApplicationController
  def new
    @favorite_pets = Pet.where(id: favorites_list.pets)
  end

  def create
    application = AdoptionApp.new(adoption_app_params)
    if application.save
      application.process(params[:selected_pet])
      favorites_list.remove_multiple(params[:selected_pet])
      flash[:notice] = "Adoption Application Successfully Submitted"
      session[:favorites_list] = favorites_list.pets
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
end
