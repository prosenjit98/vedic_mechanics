class AddPositionsCategory < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :position, :integer
    add_index :categories, [:parent_category_id, :position], unique: true, name: 'index_category_on_parent_and_position'
  end
end
