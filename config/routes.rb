Rails.application.routes.draw do
  # For details on the DSL available withi n this file, see http://guides.rubyonrails.org/routing.html
  resources :items, only:[:index, :show, :new, :create, :edit, :update]
  resources :shipments, only:[:index, :show, :new, :create]
end
