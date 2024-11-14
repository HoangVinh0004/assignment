Rails.application.routes.draw do
  root "jobs#index"
  resources :jobs, only: %i[index show] do
    resources :job_applications, only: :create, path: "apply"
  end
end
