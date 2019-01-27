Rails.application.routes.draw do
  get 'urls/index'
  resources :urls
  root 'urls#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/:token', to: 'urls#redirect'
end
