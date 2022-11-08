Rails.application.routes.draw do
  get "users/invite"
  resources :groups
  devise_for :users, controllers: { invitations: "users/invitations" }

  resources :organization_memberships, path: "users"
  # resources :users

  # do
  #   # collection do
  #   #   match :invite, via: [:get, :post]
  #   # end
  # end

  match :onboarding, to: "onboarding#index", via: [:get, :post]

  resources :productions

  # Defines the root path route ("/")
  root "productions#index"
end
