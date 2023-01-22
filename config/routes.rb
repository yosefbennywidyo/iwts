Rails.application.routes.draw do
  resources :transaction_histories
  resources :wallets
  resources :stocks
  resources :teams
  resources :users
  get '*path' => redirect('/')
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
