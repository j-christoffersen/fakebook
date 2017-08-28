Rails.application.routes.draw do

  get 'notifications/index'

  get 'hello', to: 'application#hello'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  devise_scope :user do
    get 'sign_in',  to: 'devise/sessions#new'
    get 'sign_out', to: 'devise/sessions#destroy'
    get 'sign_up',  to: 'devise/registrations#new'
  end
  
  resources :users, only: [:show, :index]
  resources :friendships, only: [:create, :destroy]
  resources :notifications, only: :index
  resources :posts, only: [:index, :create, :destroy]
  resources :likes, only: [:create,  :destroy]
  
  root 'posts#index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
