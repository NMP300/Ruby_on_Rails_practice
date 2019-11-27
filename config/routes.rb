# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {
      omniauth_callbacks: "users/omniauth_callbacks"
  }

  scope "(:locale)", locale: /en|ja/ do
    resources :books
    devise_for :users, skip: :omniauth_callback, controllers: {
        registrations: "users/registrations",
        sessions: "users/sessions",
    }
    resources :users, only: [:index, :show] do
      member do
        get :following, :followers
        get :books
      end
    end
    resources :relationships, only: [:create, :destroy]
  end
  root to: "books#index"
end
