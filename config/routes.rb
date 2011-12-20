LehaziCom::Application.routes.draw do




  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  #get "show_user" => "users#show_by_name", :as =>"show_user"

  #resources :users  , :member => {:enable => :put}  do |users|
  #  resources :roles
  #end
  #get 'articles' =>"articles#index", :as=>"articles"
  resources :articles  do
    collection do
      get 'admin'
    end
  end
  resources :categories  do
    collection do
      get 'admin'
    end
    resources :articles#, :name_prefix => 'category_' ,:path_prefix => '/categories/:category_id'
  end

  resources :users  do
    resources :roles

    member do
      put "enable"
    end
  end


  resources :forums do
    resources :topics do
       resources :posts
    end
  end

  #resources :users do
  #  put :enable, :on=> :member
  #  resource :roles
  #end

  resources :sessions

  resources :infos
  root :to => "home#index"
  resources :rent_infos

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
