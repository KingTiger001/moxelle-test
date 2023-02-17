Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "boards#new"
  
  resources :boards

  namespace :form_validations do
    resources :boards, only: [:create]
  end
end
