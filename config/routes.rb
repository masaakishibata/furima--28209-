Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root to: 'items#index'
  resources :users, only: [:create]
  resources :items, only: [:index, :new, :create, :show, :edit, :destroy, :update] do
    resources :orders, only:[:index, :create, :new,]
    collection do
      get 'item_search'
    end
  end
end