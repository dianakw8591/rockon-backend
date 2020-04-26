Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :user_climbs
      resources :climbs
      resources :areas
      resources :users
      post '/login', to: 'auth#create'
      get '/current_user', to: 'auth#show'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
