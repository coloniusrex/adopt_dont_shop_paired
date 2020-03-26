class ShelterReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    review = Review.new(review_params)
    if review.save
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      redirect_to "/shelters/#{params[:shelter_id]}/reviews/new", notice: "Oopsie Daisy! Review Not Created: Required Information Missing (Title, Rating or Content Missing!)"
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    if Review.update(params[:review_id], review_params).valid?
      Review.update(params[:review_id], review_params)
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      flash[:notice] = "Oopsie Daisy! Review Not Created: Required Information Missing (Title, Rating or Content Missing!)"
      redirect_to "/shelters/#{params[:shelter_id]}/reviews/#{params[:review_id]}/edit"
    end
  end

  def destroy
    Review.destroy(params[:review_id])
    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :image_url, :shelter_id)
  end
end
