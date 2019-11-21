# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ja/ do
    resources :books
    devise_for :users, controllers: {
        registrations: "users/registrations",
        sessions: "users/sessions",
    }
    resources :users, only: [:index, :show]
  end
  root to: "books#index"
end
