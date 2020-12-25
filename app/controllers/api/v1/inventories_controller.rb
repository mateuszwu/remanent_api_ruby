module Api
  module V1
    class InventoriesController < ApplicationController
      def create
        inventory = Inventory.new(new_inventory_params)

        if inventory.save
          render json: InventorySerializer.new(inventory, { include: [:product] }).to_json, status: :ok
        else
          render json: ErrorSerializer.new(inventory).to_json, status: :bad_request
        end
      end

      def show
        inventory = Product.find_by(barcode: params[:barcode]).inventory
        
        render json: InventorySerializer.new(inventory, { include: [:product] }).to_json, status: :ok
      end

      def index
        render json: InventorySerializer.new(Inventory.includes(:product).order('products.name'), { include: [:product] }).to_json, status: :ok
      end

      def update
        inventory = Inventory.find(params[:id])

        if inventory.update(inventory_params)
          render json: InventorySerializer.new(inventory, { include: [:product] }).to_json, status: :ok
        else
          render json: ErrorSerializer.new(inventory).to_json, status: :bad_request
        end
      end

      private

      def new_inventory_params
        new_params = params.require(:inventory).permit(:barcode, :quantity, :price)
        product = Product.find_by(barcode: new_params[:barcode])
        new_params.except(:barcode).merge(product_id: product&.id)
      end

      def inventory_params
        params.require(:inventory).permit(:quantity, :price)
      end
    end
  end
end
