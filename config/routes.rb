Rails.application.routes.draw do
  resources :books
  devise_for :users, :controllers => { registrations: 'registrations'}
  root 'index#home'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  get 'book/search' => 'search#searchInit'
  get 'book/result' => 'search#index'
  get 'borrowed' => 'borrow#borrowedBooks'
  post 'book/:id/borrowRequest' => 'borrow#borrowRequest', :as => :borrow_request
  patch 'book/:id/borrowRequest' => 'borrow#borrowRequest'
  get 'pending' => 'borrow#myBorrowRequests'
  put 'pending/accept/:id' => 'borrow#acceptBorrowRequest', :as => :accept_borrow_request
  put 'pending/reject/:id' => 'borrow#rejectBorrowRequest', :as => :reject_borrow_request
  get 'pending/recievals' => 'borrow#myConfirmedRequests'
  put 'pending/recievals/:id' => 'borrow#confirmRecieval', :as => :confirm_book_recieved
  get 'shared' => 'borrow#booksShared'
  put 'shared/returned/:id' => 'borrow#confirmReturn', :as => :confirm_book_returned
  get 'notifications' => 'notifications#index'
  put 'notifications/clearAll' => 'notifications#clearNotifications', :as => :clear_notifications
  get 'account' => 'profile#viewAccount'
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
