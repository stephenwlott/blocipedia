Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] do
    resources :wikis, only: [:new, :create, :destroy, :show, :edit, :update]
    get 'upgrade'
    get 'downgrade'
  end
  resources :charges, only: [:new, :create]
  resources :collaborators, only: [:new, :create]
  resources :wikis do
    get 'select_collaborators'
  end

  get 'welcome/index'
  get 'welcome/about'
  
  authenticated :user do
    root to: "users#show", :as => "profile"
  end
  root to: 'welcome#index'
end
