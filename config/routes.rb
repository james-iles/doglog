Rails.application.routes.draw do
devise_for :users, controllers: {
  registrations: 'users/registrations'
}
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :households, only: [:show, :new, :create, :delete, :update] do
    resources :dogs, only: [:index, :new, :create]
  end

  resources :dogs, only: [:show, :edit, :update, :destroy] do
    resources :appointments, only: [:index, :new, :create]
    resources :documents, only: [:index, :new, :create]
    resources :chats, only: [:create]
  end

  resources :appointments, only: [:show, :edit, :update, :destroy]
  resources :documents, only: [:show, :edit, :update, :destroy]

  resources :chats, only: [:show] do
    resources :messages, only: [:create]
  end
end
