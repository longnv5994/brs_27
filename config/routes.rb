Rails.application.routes.draw do
  get "users/new"

  root "static_pages#home"

  get  "/help",     to: "static_pages#help"
  get  "/about",    to: "static_pages#about"
  get  "/contact",  to: "static_pages#contact"
  get  "/signup",   to: "users#new"
  get  "/login",    to: "sessions#new"
  post "/login",    to: "sessions#create"
  delete  "/logout", to: "sessions#destroy"
  post "/signup", to: "users#create"
  get "/requests", to: "requests#show"
  get "/admin/requests", to: "admin/requests#show"


  resources :comments, only: [:create, :destroy]
  resources :categories, only: :index
  resources :books, only: [:index, :show]
  resources :requests, only: [:add, :update]
  resources :books do
    resources :reviews
  end
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :user_relationships, only: [:create, :destroy]

  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :categories
    resources :books
    resources :requests, only:[:show, :destroy, :update]
  end
  resources :requests, only: [:create, :destroy, :show]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
