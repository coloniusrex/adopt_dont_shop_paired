class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :favorites_list

  def favorites_list
    @list ||= FavoritesList.new(session[:favorites_list])
  end

  def missing_fields(params)
    missing_hash = params.keep_if{|k,v| v == ""}
    missing_keys = missing_hash.keys
    capitalize(missing_keys).join(", ")
  end

  def capitalize(array)
    array.map { |item| item.capitalize }
  end
end
