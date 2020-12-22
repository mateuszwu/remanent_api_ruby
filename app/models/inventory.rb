class Inventory < ApplicationRecord
  belongs_to :product

  validates :quantity, :price, :product_id, presence: true
  validates :quantity, :price, numericality: { greater_than_or_equal_to: 0 }
  validates :product_id, uniqueness: true
end
