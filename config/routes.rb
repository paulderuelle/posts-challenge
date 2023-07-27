Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "pages#home"

  resources :posts, only: %i[index show new create] do
    resources :comments, only: %i[create]
  end
end
