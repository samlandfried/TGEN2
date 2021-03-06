# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static#index'

  resources :questions, only: %i[index create] do
    resources :check_answer, only: :create
  end
  resources :sentences, only: %i[index create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
