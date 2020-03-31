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
    Shelter.create(shelter_params)
    redirect_to '/shelters'
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
