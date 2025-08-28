class AddVendorIdToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :vendor_id, :integer
  end
end
