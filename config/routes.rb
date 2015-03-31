Rails.application.routes.draw do
  resources :posts

  get 'about' => 'welcome#about'
  get 'contact' => 'welcome#contact'

  root to: 'welcome#index'
end
