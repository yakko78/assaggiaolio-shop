class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :sku
      t.string :title
      t.text :description
      t.decimal :capacity
      t.decimal :height
      t.decimal :diameter
      t.decimal :price

      t.timestamps null: false
    end
  end
end
