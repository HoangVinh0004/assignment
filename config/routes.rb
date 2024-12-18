Rails.application.routes.draw do
  root "jobs#index"
  resources :jobs, only: %i[index show] do
    resources :job_applications, only: :create, path: "apply"
  end
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  namespace :admin do
    resources :jobs do
      member do
        patch :publish
      end
      collection do
        get :upload
        post :import
      end
    end
  end
end
