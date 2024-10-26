class CreateProductConcerns < ActiveRecord::Migration[7.1]
  def change
    create_table :product_concerns do |t|
      t.references :product, null: false, foreign_key: true
      t.references :concern, null: false, foreign_key: true
      t.timestamps
    end
  end
end
