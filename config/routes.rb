Rails.application.routes.draw do
  devise_for :users, controllers: { invitations: "users/invitations" }

  get "calendar", to: "calendar#index"

  get "users/invite"

  resources :productions do
    member do
      get :calendar
    end
    resources :groups
    resources :events
  end

  resources :groups
  resources :events

  resources :organization_memberships, path: "users"

  match :onboarding, to: "onboarding#index", via: [:get, :post]

  # Defines the root path route ("/")
  root "calendar#index"
end
