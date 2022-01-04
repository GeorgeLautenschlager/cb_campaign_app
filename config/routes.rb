Rails.application.routes.draw do
  # Default route
  root "users#show"

  # Routes set up by gems/rails
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  # Routes set up by models
  resources :users, only: [:show]
end
