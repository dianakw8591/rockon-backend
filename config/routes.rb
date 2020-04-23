Rails.application.routes.draw do
  resources :user_climbs
  resources :climbs
  resources :areas
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
