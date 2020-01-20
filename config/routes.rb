Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :articles do
      resources :comments, except: :update
    end
  end
end
