Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] do
    resources :wikis, only: [:new, :create, :destroy, :show, :edit, :update]
  end
  
  get 'welcome/index'
  get 'welcome/about'

  authenticated :user do
    root to: "users#show", :as => "profile"
  end
  root to: 'welcome#index'
end
