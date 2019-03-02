Rails.application.routes.draw do
  get 'home/index'
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :urls
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/:token', to: 'urls#redirect'
  get 'signup' => 'home#sign_up'
end
