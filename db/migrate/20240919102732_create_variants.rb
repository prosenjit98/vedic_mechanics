class CreateVariants < ActiveRecord::Migration[7.1]
  def change
    create_table :variants do |t|
      t.string :title

      t.timestamps
    end
  end
end
