Rails.application.routes.draw do
  devise_for :users
  
  root "pages#home"
  get "about", to: "pages#about"

  resources :profiles, param: :public_uid, only: [ :index, :new, :create, :show, :edit, :update, :destroy ]
end
