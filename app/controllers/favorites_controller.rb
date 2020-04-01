class FavoritesController < ApplicationController
  def index
    @favorite_pets = Pet.where(id: favorites_list.pets)
    @pets_with_applications = Pet.joins(:adoption_apps).distinct

  end

  def destroy
    favorites_list.remove_all
    session[:favorites_list] = favorites_list.pets
    redirect_to '/favorites'
  end
end
