Rails.application.routes.draw do
  devise_for :users
  get '/', to: 'home#index'
  resources :rooms do
    resources :messages
  end
  resources :users, only: [:show]
end
