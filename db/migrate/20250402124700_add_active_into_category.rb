class AddActiveIntoCategory < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :is_active, :boolean, default: true
  end
end
