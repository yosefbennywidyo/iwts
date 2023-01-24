Rails.application.routes.draw do
  concern :transaction_historyable do
    resources :transaction_histories, param: :number, only: [:index] do
      collection do
        get 'debit', controller: 'transaction_histories', action: 'debit'
        get 'credit', controller: 'transaction_histories', action: 'credit'
        post 'new_debit', controller: 'transaction_histories', action: 'new_debit'
        post 'new_credit', controller: 'transaction_histories', action: 'new_credit'
      end
    end
  end

  resources :users, :teams, :stocks, param: :code do
    concerns :transaction_historyable
  end
  
  get '*path' => redirect('/')
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
