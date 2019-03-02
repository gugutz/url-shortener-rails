Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  get 'urls/index'
  resources :urls
  root 'urls#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/:token', to: 'urls#redirect'
  get 'signup' => 'urls#sign_up'
end
