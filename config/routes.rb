Rails.application.routes.draw do
  devise_for :users
  get '/', to: 'home#index'
  resources :rooms do
    resources :messages, only: [:index, :create]
    get :participants, on: :member
  end
  resources :users, only: [:index, :show]
end