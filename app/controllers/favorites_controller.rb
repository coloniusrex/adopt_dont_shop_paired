class FavoritesController < ApplicationController
  def index
    @favorite_pets = Pet.where(id: favorites_list.pets)
  end
end
