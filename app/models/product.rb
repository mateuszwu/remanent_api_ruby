class Product < ApplicationRecord
  validates :barcode, :name, :unit, presence: true
  validates :barcode, uniqueness: true
end
