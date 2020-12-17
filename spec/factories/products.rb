FactoryBot.define do
  factory :product do
    sequence(:barcode) { |n| "barcode#{n}" }
    name { 'Water' }
    unit { 'szt.' }
  end
end
