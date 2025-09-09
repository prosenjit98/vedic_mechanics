class RemoveCategoryIndex < ActiveRecord::Migration[7.1]
  def change
    remove_index :categories, name: 'index_category_on_parent_and_position'
    add_index :categories, [:parent_category_id, :position], unique: false, name: 'index_category_on_parent_and_position'
  end
end
