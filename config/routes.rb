Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  resources :users, only: [:create, :show , :destroy] do
    get 'skills', to: 'users#skills'
  end
  get 'skills', to: 'skills#index'
  resources :results, only: [:index, :create]
end
