FactoryBot.define do
  factory :inventory do
    product { create(:product) }
    quantity { 1 }
    price { 2 }
  end
end
