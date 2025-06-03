Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', registration: 'signup' }, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  resources :users, only: [:index, :show] do
    collection do
      get :me
      patch :update_avatar
    end
    member do
      get :avatar
    end
  end
  resources :rooms, only: [:index, :show, :create] do
    member do
      get :participants
    end
    resources :messages, only: [:index, :create]
  end
  root to: 'home#index'
end