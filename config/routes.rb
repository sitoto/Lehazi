LehaziCom::Application.routes.draw do

  resources :ads

  resources :friend_links

if Rails.env.development?
  match "/images/uploads/*path" => "gridfs#serve"
end
  get "index/friend_links" => "friend_links#index" ,:as => "friend_links"

  get "blogs"  => "blog#index", :as => "blogs"

  root :to => "home#index"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get "we" =>  "we#index", :as => "we"
  get "tieba" =>  "we#tieba", :as => "tieba"
  get "tianya" =>  "we#tianya", :as => "tianya"
  get "douban" =>  "we#douban", :as => "douban"

  resources :tags

  resources :users  do
    resources :entries do
      resources :comments
    end

    resources :roles
      member do
        put "enable"
    end

  end
  resources :games do
    collection do
      get 'admin'
    end
  end
  resources :articles  do
    collection do
      get 'admin'
      get 'tag/:tag_id' ,:action => "index"
    end
  end
  resources :funs do
    collection do
      get 'admin'
      get 'tag/:tag_id' ,:action => "index"
    end
   end
  resources :novels  do
    collection do
      get 'admin'
    end
  end
  resources :categories  do
    collection do
      get 'admin'
    end
    resources :articles#, :name_prefix => 'category_' ,:path_prefix => '/categories/:category_id'
    resources :funs
    resources :games
  end

  resource :topics do
    collection do
      get 'tag/:tag_id' ,:action => "index"
    end
  end
  resources :forums do
    resources :topics do
      collection do
        get "newtopic"
        get "last"
      end
       resources :posts
    end
  end

  resources :sessions
  resources :infos

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
