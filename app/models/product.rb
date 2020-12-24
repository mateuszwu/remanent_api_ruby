class Product < ApplicationRecord
  has_one :inventory

  validates :barcode, :name, :unit, presence: true
  validates :barcode, uniqueness: true
end
