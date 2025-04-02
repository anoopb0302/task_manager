Rails.application.routes.draw do
  root "tasks#index"  # Set the homepage to task list
  resources :tasks  # Existing Task routes
  resources :progress
end
