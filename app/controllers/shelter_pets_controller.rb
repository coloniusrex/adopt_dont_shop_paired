class ShelterPetsController < ApplicationController

  def index
    @shelter = Shelter.find(params[:shelter_id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    shelter.pets.create(shelter_pet_params)
    redirect_to "/shelters/#{params[:shelter_id]}/pets"
  end

  private

  def shelter_pet_params
    params[:adoptable] = true
    params.permit(:image_url, :name, :description, :approximate_age,
                           :sex, :adoptable)
  end
end
