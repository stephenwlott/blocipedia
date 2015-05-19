Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  
  get 'welcome/index'
  get 'welcome/about'

  authenticated :user do
    root to: "users#show", :as => "profile"
  end
  root to: 'welcome#index'
end
