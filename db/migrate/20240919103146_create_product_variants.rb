class CreateProductVariants < ActiveRecord::Migration[7.1]
  def change
    create_table :product_variants do |t|
      t.references :variant, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :value, null: false

      t.timestamps
    end
  end
end
