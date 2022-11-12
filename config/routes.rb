Rails.application.routes.draw do
  resources :locations
  devise_for :users, controllers: { users: "users", invitations: "users/invitations" }

  resource :calendar, controller: "calendar" do
  end

  get "users/invite"

  resources :productions do
    member do
      get :calendar
      get :first_calls, to: "first_calls"
    end
    resources :groups do
      resources :group_memberships
    end
    resources :events do
      member do
        get :flyout
      end
    end
    resources :locations
  end

  resources :groups

  resources :events

  resources :organization_memberships, path: "users"

  match :onboarding, to: "onboarding#index", via: [:get, :post]

  # Defines the root path route ("/")
  root "productions#index"
end
