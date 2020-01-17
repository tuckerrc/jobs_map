Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'stack_jobs#index', via: [:get, :post] 
  get 'static/pages'

  get 'static/index'

  get 'stack_jobs/index' => "stack_jobs#index"
  post 'stack_jobs/index' => "stack_jobs#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
