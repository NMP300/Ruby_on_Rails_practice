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
    resources :users, only: [:index, :show]
  end
  root to: "books#index"
end
