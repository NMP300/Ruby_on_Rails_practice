# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: "users/sessions"}
  scope "(:locale)", locale: /en|ja/ do
    resources :books
  end

  root to: "books#index"
end
