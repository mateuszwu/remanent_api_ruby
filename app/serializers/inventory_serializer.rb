class InventorySerializer
  include JSONAPI::Serializer
  attributes :id, :quantity, :price

  belongs_to :product
end
