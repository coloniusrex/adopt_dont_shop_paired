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
      flash[:error] = "Incomplete Submission: Please fill out #{missing_fields(shelter_params)} to complete your form."
      redirect_to request.referer
    end

  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    if Shelter.update(params[:id], shelter_params).valid?
      shelter = Shelter.update(params[:id], shelter_params)
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:error] = "Incomplete Submission: Please fill out #{missing_fields(shelter_params)} to complete your form."
      redirect_to request.referer
    end
  end

  def destroy
    shelter = Shelter.find(params[:id])
    if shelter.pets_pending_adoption?
      flash[:error] = "Can not delete shelter. Pet adoption currently pending."
      redirect_to request.referer
    else
      shelter.destroy_dependencies
      shelter.destroy
      redirect_to '/shelters'
    end
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end
