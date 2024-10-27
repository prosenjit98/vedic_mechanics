class CreateAppConfigurations < ActiveRecord::Migration[7.1]
  def change
    create_table :app_configurations do |t|
      t.string :key
      t.string :value
      t.json :meta
      
      t.timestamps
    end
  end
end
