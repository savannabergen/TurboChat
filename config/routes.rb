Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root to: 'home#index'

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', registration: 'signup' }, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources :rooms, only: [:index, :show, :create] do
  member do
    get :participants
  end
  resources :messages, only: [:index, :create]
  end
end