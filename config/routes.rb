OrderSamplex::Engine.routes.draw do
  resources :samples
  
  root :to => 'samples#index'

end
