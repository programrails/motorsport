# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#index'

  get 'sales', to: 'sales#index'

  get 'main', to: 'main#index'

  post 'main', to: 'main#create'

  resources :incomes

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :products do
        resources :incomes, only: %i[show index]
      end
    end
  end

  namespace :admin do
    resources :products
  end
end
