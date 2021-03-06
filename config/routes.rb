Rails.application.routes.draw do
  
  resources :users

  resource :session

  get 'signin' => "sessions#new"

  root "series#index"

  get '/series/:id/redeemed' => "series#show", scope: 'redeemed', as: 'series_redeemed'
  get '/series/:id/unredeemed' => "series#show", scope: 'unredeemed', as: 'series_unredeemed'

  resources :series do 
    resources :comics do 
    	post 'toggle_redeemed', :on => :member
    end
  end

end
