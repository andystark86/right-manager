RightManager::Engine.routes.draw do

  resources :groups
  resources :users, only: [:index, :show, :edit, :update]
  resources :roles do
    member do
      patch :update_single_right
    end

    collection do
      get :matrix
    end
  end
  resources :rights, only: [:index, :show, :edit, :update]

  root to: "roles#index"
end