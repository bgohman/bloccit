Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:update]

  resources :advertisements
  
  resources :topics do
    resources :posts, except: [:index]
  end

  resources :posts, only: [] do 
    resources :questions
    resources :comments
    resources :summaries
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end



  get 'about' => 'welcome#about'
  get 'contact' => 'welcome#contact'

  root to: 'welcome#index'
end
