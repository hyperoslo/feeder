Rails.application.routes.draw do
  mount Feeder::Engine => "/feeder"
end
