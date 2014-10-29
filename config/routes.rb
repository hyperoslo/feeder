Feeder::Engine.routes.draw do
  resources :items, path: '/(.:format)', only: :index do
    member do
      post :report
      post :unreport
      post :recommend
      post :unrecommend
      post :like
      post :unlike
    end
  end
end
