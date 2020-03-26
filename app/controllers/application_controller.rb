class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :favorite

  def favorite
    return session[:favorites_list] unless session[:favorites_list].nil?
    []
  end
end
