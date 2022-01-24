Rails.application.routes.draw do
  # Default route
  # root "users#show"
  root "briefing_room#briefing"

  # Routes set up by gems/rails
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  # Routes set up by models
  resources :users, only: [:show]

  # Non-restful URLs
  get 'users/:id/mulligan', to: 'users#mulligan', as: :mulligan
  get 'briefing_room', to: 'briefing_room#briefing', as: :briefing_room
  get 'roster', to: 'briefing_room#roster', as: :roster
  get 'map', to: 'briefing_room#map', as: :map
  get 'stats', to: 'briefing_room#stats', as: :stats
end
