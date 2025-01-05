class AddUnitCost < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :unit_cost, :float
  end
end
