Rails.application.routes.draw do
  root "person#index"


  get 'list' => 'person#list'
  get 'new' => 'person#new'
  post 'create' => 'person#create'
  resources :interviews
  get 'reports' => 'interviews#reports'
end
