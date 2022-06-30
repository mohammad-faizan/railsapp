Rails.application.routes.draw do
  get 'list' => 'person#list'
  get 'new' => 'person#new'
  post 'create' => 'person#create'
  resources :interviews
  root "person#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
