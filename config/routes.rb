Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :inventories, only: %i(create index update)
      resources :products, only: %i(create show update), param: :barcode
    end
  end
end
