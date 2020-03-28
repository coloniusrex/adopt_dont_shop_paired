class AdoptionAppsController < ApplicationController
  def new
    @favorite_pets = Pet.where(id: favorites_list.pets)
  end
end
