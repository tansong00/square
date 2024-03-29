Square::Application.routes.draw do
  root 'dashboards#index'

  get 'search' => 'dashboards#search', as: :search

  delete 'logout' => 'sessions#destroy', as: :logout

  resources :albums do
    member do
      get :new_attach
      post :create_attach
      match :authorize, via: [:get, :post]
      get :download
    end
  end
  resources :comments, only: [:create] do
    collection do
      get :owns
    end
  end
  resources :pictures do
    collection do
      post :upload
    end
  end
  resources :tasks do
    collection do
      get :tmp
      delete :remove_album
    end
    member do
      match :publish, via: [:get, :patch]
      get :new_attach
      post :create_attach
      patch :add_pic
      get :list_pic
    end
  end
  resources :sessions, only: [:new, :create]
  resources :users
  resources :attachments, only: [:destroy] do
    get :download, on: :member
  end
  resources :roles, only: [:index, :destroy]


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
