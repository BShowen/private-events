Rails.application.routes.draw do
  root "users#new"
  get "/logout", to: "sessions#destroy"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  resources :users, only: [:new, :create, :show]
  resources :events, only: [:new, :index, :show, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
