# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {
      omniauth_callbacks: "users/omniauth_callbacks"
  }

  scope "(:locale)", locale: /en|ja/ do
    resources :books, :reports do
      resources :comments
    end

    devise_for :users, skip: :omniauth_callback, controllers: {
        registrations: "users/registrations",
        sessions: "users/sessions",
    }
    resources :users, only: [:index, :show] do
      member do
        resources :following, only: [:index]
        resources :followers, only: [:index]
      end
    end
    resources :follows, only: [:create, :destroy]
    resources :comments
  end
  root to: "books#index"
end
