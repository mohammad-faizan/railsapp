Rails.application.routes.draw do
  root "people#index"

  resources :people
  resources :interviews

  get 'list' => 'people#list'
  get 'reports' => 'interviews#reports'
end
