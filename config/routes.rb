Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :inventories, only: %i(create index update)
      resources :inventories, only: %i(show), param: :barcode
      resources :products, only: %i(create index show update), param: :barcode
    end
  end
end
