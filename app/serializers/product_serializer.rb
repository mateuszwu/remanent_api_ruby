class ProductSerializer
  include JSONAPI::Serializer
  attributes :barcode, :name, :unit
end
