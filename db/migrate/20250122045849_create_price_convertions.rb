class CreatePriceConvertions < ActiveRecord::Migration[7.1]
  def change
    create_table :price_conversions do |t|
      t.string :currency
      t.float :rate

      t.timestamps
    end
  end
end
