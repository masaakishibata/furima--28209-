Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :users, only: [:create]
  resources :items, only: [:index, :new, :create, :show, :edit, :destroy, :update] do
    resources :orders, only:[:index, :create, :new,]
    collection do
      get 'search'
    end
  end
end