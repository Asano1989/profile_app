Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
    confirmations: "users/confirmations"
  }

  root "pages#home"
  get "about", to: "pages#about"

  resources :users, only: [ :show ]
  resources :profiles, param: :public_uid, only: [ :index, :new, :create, :show, :edit, :update, :destroy ]
end
