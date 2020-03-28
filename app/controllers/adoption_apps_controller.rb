class AdoptionAppsController < ApplicationController
  def new
    @favorite_pets = Pet.where(id: favorites_list.pets)
  end

  def create
    application = AdoptionApp.create(adoption_app_params)
    application.process(params[:selected_pet])
    favorites_list.remove_multiple(params[:selected_pet])
    session[:favorites_list] = favorites_list.pets
    flash[:notice] = "Adoption Application Successfully Submitted"
    redirect_to "/favorites"
  end

  private

  def adoption_app_params
    params.permit(:name, :address, :city, :state,
                  :zip, :phone_number, :description)
  end
end
