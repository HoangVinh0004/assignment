Rails.application.routes.draw do
  root "jobs#index"
  resources :jobs, only: %i[index show]
end
