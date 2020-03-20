# frozen_string_literal: true

Rails.application.routes.draw do
  resources :questions, only: %i[index create]
  resources :sentences, only: %i[index create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
