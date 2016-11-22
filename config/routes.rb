Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  scope 'admin' do
    get '/dashboard' => 'admin#dashboard', as: :admin_dashboard
    get '/instructors' => 'admin#instructors', as: :admin_instructors
    get '/settings' => 'admin#settings', as: :admin_settings
    get '/courses' => 'admin#courses', as: :admin_courses
    get '/seo_pages' => 'admin#seo_pages', as: :admin_seo_pages
    get '/seo_pages/:page_id' => 'admin#edit_page', as: :admin_edit_seo_page
    get 'instructors/:user_id' => 'admin#view_instructor', as: :admin_view_instructors
  end


  get 'category_view' => 'welcome#category_view'


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :courses, only: :index do
    get '/:category', to: :category_courses, as: :category, on: :collection
  end

  resources :instructors, only: [] do
    collection do
      get :dashboard
      get '/course/new', to: :new_course #, as: :new_course
      get '/course/:id/edit', to: :edit_course, as: :edit_course
      post '/course', to: :create_course, as: :create_course
      put '/course/:id', to: :update_course, as: :update_course
      delete '/course/:id', to: :delete_course, as: :delete_course
    end
  end

  get :page, to: 'welcome#edit_page'

  get '/:slug', to: 'courses#show', as: :course

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
