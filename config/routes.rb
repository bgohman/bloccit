Rails.application.routes.draw do

  devise_for :users
  resources :advertisements

  resources :posts do 
    resources :questions
    resources :comments
  end

  get 'about' => 'welcome#about'
  get 'contact' => 'welcome#contact'

  root to: 'welcome#index'
end
