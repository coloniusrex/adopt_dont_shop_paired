Rails.application.routes.draw do
  #shelters
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'
  #pets
  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'
  #shelter_pets
  get '/shelters/:shelter_id/pets', to: 'shelter_pets#index'
  get '/shelters/:shelter_id/pets/new', to: 'shelter_pets#new'
  post '/shelters/:shelter_id/pets', to: 'shelter_pets#create'
  #shelter_review
  get '/shelters/:shelter_id/reviews/new', to: 'shelter_reviews#new'
  post '/shelters/:shelter_id/reviews', to: 'shelter_reviews#create'
  get '/shelters/:shelter_id/reviews/:review_id/edit', to: 'shelter_reviews#edit'
  patch '/shelters/:shelter_id/reviews/:review_id', to: 'shelter_reviews#update'
  delete '/shelters/:shelter_id/reviews/:review_id/delete', to: 'shelter_reviews#destroy'
  #landing page
  get '/', to: 'welcome#index'
  #pets_favorites
  patch '/pets/:pet_id/favorites', to: 'pets_favorites#update'
  delete 'favorites/:pet_id', to: 'pets_favorites#destroy'
  #favorites
  get '/favorites', to: 'favorites#index'
  delete '/favorites', to: 'favorites#destroy'
  #adoption_apps
  get '/adoption_apps/new', to: 'adoption_apps#new'
  post '/adoption_apps', to: 'adoption_apps#create'
  get '/adoption_apps/:id', to: 'adoption_apps#show'
  #pets_adoption_apps
  get '/pets/:pet_id/adoption_apps', to: 'pets_adoption_apps#index'
  patch '/pets/:pet_id/adoption_apps/:app_id', to: 'pets_adoption_apps#update'
  delete '/pets/:pet_id/adoption_apps', to: 'pets_adoption_apps#delete'

end
