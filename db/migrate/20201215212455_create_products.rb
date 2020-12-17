class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :barcode, null: false, default: ''
      t.string :name, null: false, default: ''
      t.string :unit, null: false, default: 'szt.'

      t.timestamps
    end

    add_index :products, :barcode, unique: true
  end
end
