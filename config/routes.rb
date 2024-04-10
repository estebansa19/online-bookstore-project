Rails.application.routes.draw do
  root 'books#index'
  get 'up' => 'rails/health#show', as: :rails_health_check

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :books, only: %i[index show]

  resources :orders, only: %i[show update]
  get '/cart', to: 'orders#cart'

  namespace :orders do
    resources :books, only: %i[create destroy]
  end

  namespace :admin do
    resources :books, except: %i[show]
  end
end
