Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'

  resources :profiles, only: [:index, :new, :create, :show]
end
