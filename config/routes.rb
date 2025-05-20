Rails.application.routes.draw do
  get '/', to: 'home#index'
  resources :rooms do
    resources :messages
  end
  resources :users, only: [:show]
end
