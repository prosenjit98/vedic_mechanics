class CreateSiteRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :site_ratings do |t|
      t.integer :rate
      t.string :external_user_id

      t.timestamps
    end
  end
end
