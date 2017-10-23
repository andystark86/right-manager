Rails.application.routes.draw do
  
  resources :people
  mount RightManager::Engine => "/right_managerx"

  root to: "people#index"
end
