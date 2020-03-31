class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    shelter = Shelter.new(shelter_params)
    if shelter.save
      redirect_to '/shelters'
    else
      flash[:error] = "Incomplete Submission: Please fill out #{missing_fields} to complete your form."
      redirect_to request.referer
    end

  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    shelter = Shelter.find(params[:id])
    shelter.pets.delete_all
    shelter.destroy
    redirect_to '/shelters'
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def missing_fields
    missing_hash = shelter_params.keep_if{|k,v| v == ""}
    missing_keys = missing_hash.keys
    capitalize(missing_keys).join(", ")
  end

  def capitalize(array)
    array.map { |item| item.capitalize }
  end
end
