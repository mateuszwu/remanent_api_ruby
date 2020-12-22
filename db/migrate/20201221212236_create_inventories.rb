class CreateInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :inventories do |t|
      t.decimal :quantity, null: false, default: 0.0, precision: 18, scale: 2
      t.decimal :price, null: false, default: 0.0, precision: 18, scale: 2
      t.references :product, null: false, foreign_key: true, index: {unique: true}

      t.timestamps
    end
  end
end
