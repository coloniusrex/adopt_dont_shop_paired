class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :favorites_list

  def favorites_list
    return session[:favorites_list] unless session[:favorites_list].nil?
    []
  end
end
