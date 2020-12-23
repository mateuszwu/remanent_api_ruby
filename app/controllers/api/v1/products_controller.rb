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

      def index
        render json: ProductSerializer.new(Product.all).to_json, status: :ok
      end

      def show
        product = Product.find_by(barcode: params[:barcode])

        if product
          render json: ProductSerializer.new(product).to_json, status: :ok
        else
          head :not_found
        end
      end

      def update
        product = Product.find_by(barcode: params[:barcode])

        if product.update(product_params)
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
