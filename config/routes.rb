Feeder::Engine.routes.draw do
  resources :items, path: '/(.:format)', only: :index do
    member do
      post :recommend
    end
  end
end
