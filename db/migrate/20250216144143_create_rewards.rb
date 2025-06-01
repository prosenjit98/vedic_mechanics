class CreateRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :rewards do |t|
      t.string :name
      t.string :description
      t.integer :points
      t.integer :validity
      t.boolean :is_active

      t.timestamps
    end
  end
end
