Rails.application.routes.draw do
  resources :cards do
    collection do
      post :import
    end
  end
  root 'cards#index'
end
