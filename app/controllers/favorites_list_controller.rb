class FavoritesListController < ApplicationController
  def update
    session[:favorites_list] ||= []
    if session[:favorites_list].include?(params[:pet_id])
      flash[:error] = 'You already have this pet in your favorites list!'
      redirect_to "/pets/#{params[:pet_id]}"
    else
      session[:favorites_list] << params[:pet_id]
      flash[:notice] = 'You successfully added a pet to your favorites list!'
      redirect_to "/pets/#{params[:pet_id]}"
    end
  end
end
