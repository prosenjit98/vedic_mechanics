class AddProductCodeToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :product_code, :string
  end
end
