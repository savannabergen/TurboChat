Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', registration: 'signup' },
             controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

   resources :rooms do
    member do
      get :participants
    end
    resources :messages, only: [:index, :create]
  end
  resources :users, only: [:index]
end