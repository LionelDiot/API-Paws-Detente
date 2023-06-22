class CreateLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :line_items do |t|
      t.integer :quantity, null: false

      t.references :item, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true

      t.timestamps
    end
  end
end
