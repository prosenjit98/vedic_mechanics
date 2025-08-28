class AddGstToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :gst, :float, default: 0
    add_column :carts, :price_with_gst, :float
    add_column :orders, :offer_discount, :float, default: 0
    change_column :order_items, :price, :float
    change_column :orders, :total_with_gst, :float
    change_column :orders, :delivery_cost, :float
    change_column :products, :price, :float
    change_column :products, :mfg_cost, :float
    change_column :products, :approx_delivery_cost, :float
    change_column :payments, :amount, :float
    change_column :cart_items, :price, :float
  end
end
