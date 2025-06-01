class CreateConcerns < ActiveRecord::Migration[7.1]
  def change
    create_table :concerns do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
