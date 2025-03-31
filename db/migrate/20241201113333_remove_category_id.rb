class RemoveCategoryId < ActiveRecord::Migration[7.1]
  def up
    Product.with_deleted.all.each do |product|
      category = Category.find(product.category_id)
      product.categories << category
    end
    remove_column :products, :category_id
  end

  def down
    add_column :products, :category_id, :integer
  end
end
