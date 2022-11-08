Rails.application.routes.draw do
  devise_for :users, controllers: { invitations: "users/invitations" }

  get "calendar", to: "calendar#index"
  resources :events do
    member do
      get :flyout
    end
  end
  get "users/invite"

  resources :productions

  resources :groups
  resources :organization_memberships, path: "users"

  match :onboarding, to: "onboarding#index", via: [:get, :post]

  # Defines the root path route ("/")
  root "productions#index"
end
