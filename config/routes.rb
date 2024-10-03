Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html  
  # Defines the root path route ("/")
  root to: "home#index"

  devise_for :users, controllers: { sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :employees

  devise_scope :user do
    get 'otp_verification', to: 'users/sessions#otp_verification', as: :otp_verification
    post 'verify_otp', to: 'users/sessions#verify_otp', as: :verify_otp
  end

  resources :tasks

  resources :users do
    resources :tasks do
      member do
        get :mark_completed
        post :upload_document
      end
    end
  end
end
