class ShelterPetsController < ApplicationController

  def index
    @shelter = Shelter.find(params[:shelter_id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    pet = shelter.pets.new(pet_params)
    if pet.save
      redirect_to "/shelters/#{params[:shelter_id]}/pets"
    else
      flash[:error] = "Incomplete Submission: Please fill out #{missing_fields(pet_params)} to complete your form."
      redirect_to request.referer
    end
  end

  private

  def pet_params
    params.permit(:image_url, :name, :description, :approximate_age, :sex)
  end
end
