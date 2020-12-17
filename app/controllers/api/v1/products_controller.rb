module Api
  module V1
    class ProductsController < ApplicationController
      def create
        product = Product.new(product_params)

        if product.save
          render json: ProductSerializer.new(product).to_json, status: :ok
        else
          render json: ErrorSerializer.new(product).to_json, status: :bad_request
        end
      end

      private

      def product_params
        params.require(:product).permit(:barcode, :name, :unit)
      end
    end
  end
end
