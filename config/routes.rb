# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ja/ do
    resources :books
    devise_for :users, controllers: {
        registration: "users/registrations",
        sessions: "users/sessions"
    }
    resources :users, only: [:show]
  end
  root to: "books#index"
end
