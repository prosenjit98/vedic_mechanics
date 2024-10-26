class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.text :name
      t.text :description

      t.timestamps
    end
  end
end
