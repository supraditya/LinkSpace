Rails.application.routes.draw do
  resources :groups do
    resources :group_users do
      member do
        patch :make_admin
        patch :remove_admin
      end
    end
    resources :links
  end
  devise_for :users
  root "groups#index"
end
