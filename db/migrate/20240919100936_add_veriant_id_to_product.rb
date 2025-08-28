class AddVeriantIdToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :hsn, :string
    add_column :products, :variant, :jsonb
  end
end
