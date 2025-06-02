Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  constraints format: :json do
    resources :rooms, path: '/api/rooms' do
      member do
        get :participants
      end
      resources :messages, path: '/api/rooms/:room_id/messages', only: [:index, :create]
    end
    resources :users, path: '/api/users', only: [:index]
  end
end