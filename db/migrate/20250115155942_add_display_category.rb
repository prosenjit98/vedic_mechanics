class AddDisplayCategory < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :display_category, :string
  end
end
