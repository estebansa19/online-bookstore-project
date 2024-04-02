class CreateOrdersBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :orders_books do |t|
      t.references :order, null: false, foreign_key: true, index: true
      t.references :book, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
