class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.string :item_title
      t.integer :item_price
      t.integer :quantity
      t.integer :line_item_price

      t.timestamps
    end
  end
end
