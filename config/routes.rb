Rails.application.routes.draw do
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :users

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end

  namespace :admin do
    resources :genres, only: [:index, :edit, :create, :update]
  end

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end

  namespace :admin do
    resources :orders, only: [:show, :update]
  end

  namespace :admin do
    resources :order_details, only: [:update]
  end

  namespace :admin do
    root to: 'homes#top'
  end

  scope module: :public do
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  scope module: :public do
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete' => 'orders#complete'
    get  "orders/confirm" => redirect("orders/complete")
    post 'orders' => 'orders#create'
    resources :orders, only: [:new, :index, :show]

  end

  scope module: :public do
    delete 'cart_items' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :create, :update, :destroy]

  end

  scope module: :public do
    get 'customers/confirm_withdraw' => 'customers#confirm_withdraw'
    patch 'customers/withdraw' => 'customers#withdraw'
    resources :customers, only: [:edit, :show, :update]

  end

  scope module: :public do
    resources :items, only: [:index, :show]
  end

  scope module: :public do
    root to: "homes#top"
    get "home/about"=>"homes#about"
  end

  get "search" => "searches#search"
  



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
