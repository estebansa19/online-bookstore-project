class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title, null: false, index: true
      t.string :author, null: false
      t.text :description, null: false
      t.float :price, precision: 10, scale: 2, default: 0
      t.integer :pages_number, null: false, default: 0
      t.integer :stock_quantity, null: false, default: 0

      t.timestamps
    end

    add_index :books, %i[title author], unique: true
  end
end
