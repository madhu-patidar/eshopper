Rails.application.routes.draw do

  
  get 'reports/sale_order'

  get 'reports/customer_registered'

  get 'reports/coupons_used'


  get 'coupons/destroy'
  get 'coupons/create'

  
  

  resources :contacts

  resources :wish_lists, only: [:index, :create, :destroy]

  resources :customer_orders, only: [:index, :create]
  
  resources :customer_orders do
    member do
      get 'payment'
      get 'cancel_order'
      get 'invoice'
      get 'order_detail'
    end
  end

  resources :charges do
    member do
      get 'payment_success'
    end
  end

  resources :addresses, only: [:create, :edit, :update, :destroy]

  resources :checkouts, only: [:index]

  get 'review_payment', to: "checkouts#review_payment"
   
  resources :cart_items

  resources :products, only: [:show]

  resources :categories, only: [:show] do
    resources :brands, only: [:index, :show]
  end

  resources :brands, only: [:index, :show]

  resources :charges
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :customers, :controllers => { :omniauth_callbacks => "customers/omniauth_callbacks" }
  as :user do
  get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'  
  put 'users' => 'devise/registrations#update', :as => 'user_registration'            
end

  resources :customers do
    member do
      get 'cart'
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get "*unmatched_routes" => "application#render_404"

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
