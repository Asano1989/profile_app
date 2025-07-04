Rails.application.routes.draw do
  devise_for :users
  
  root "pages#home"
  get "about", to: "pages#about"

  resources :profiles, only: [ :index, :new, :create, :show ]
end
