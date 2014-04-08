Feeder::Engine.routes.draw do
  resources :feeds, path: '/(.:format)', only: :index
end
