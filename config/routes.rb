Rails.application.routes.draw do
  root "static_pages#home"
  get "/logout", to: "sessions#destroy"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  resources :users, only: [:new, :create, :show]
  resources :events, only: [:new, :index, :show, :create]
end
