Feeder::Engine.routes.draw do
  resources :items, path: '/(.:format)', only: :index
end
