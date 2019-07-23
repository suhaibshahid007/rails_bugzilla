# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'projects#index'
  resources :projects do
    member do
      get :add_user, :remove_user
    end
    resources :bugs do
      member do
        get :assign_developer
        get :change_status
      end
    end
  end
end
