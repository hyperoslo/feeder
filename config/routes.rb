Feeder::Engine.routes.draw do
  root to: 'items#index', path: '(.:format)', as: 'items'
  resources :items, path: '', only: :show do
    member do
      post :report
      post :recommend
      post :unrecommend
      post :like
      post :unlike
    end
  end
end
