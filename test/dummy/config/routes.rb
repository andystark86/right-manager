Rails.application.routes.draw do
  
  resources :people
  mount RightManager::Engine => "/right_manager"

  root to: "people#index"
end
