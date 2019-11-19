Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'stories#welcome', as: 'home'

  get 'build' => 'stories#build_story'

  resources :stories

  resources :verbs

  resources :object_or_types, only: [:new, :create, :update, :edit, :destroy]
end
