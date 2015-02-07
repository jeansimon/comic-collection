Rails.application.routes.draw do
  
  root "series#index"

  resources :series do 
    resources :comics do 
    	post 'toggle_redeemed', :on => :member
    end
  end

end