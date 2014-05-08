Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end
  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"
  root to: "posts#index"
end
