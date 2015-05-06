Rails.application.routes.draw do



  devise_for :users
  resources :users, only: [:update]

  resources :advertisements
  
  resources :topics do
    resources :posts, except: [:index] do 
      resources :questions
      resources :comments
      resources :summaries
    end
  end  
  

  get 'about' => 'welcome#about'
  get 'contact' => 'welcome#contact'

  root to: 'welcome#index'
end
