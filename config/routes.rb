Rails.application.routes.draw do
  resources :groups do
    resources :group_users
    resources :links
  end
  devise_for :users
  root "groups#index"
end
