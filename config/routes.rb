Rails.application.routes.draw do
  get '/signup', to: 'home#signup'
  get '/login', to: 'home#login'
  get '/', to: 'home#index'
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :urls
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/:token', to: 'urls#redirect'
end

