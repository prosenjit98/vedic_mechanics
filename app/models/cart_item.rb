class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  attr_accessor :external_user_id

  after_save :update_cart_price
  after_destroy :update_cart_price

  def update_cart_price
    total_price = self.cart.cart_items.joins(:product).sum('products.price * cart_items.quantity')
    total_price_with_gst = self.cart.cart_items.joins(:product).sum('products.price * cart_items.quantity * (1 + products.gst/100)')
    self.cart.update(total_price: total_price, price_with_gst: total_price_with_gst)
  end

  def test
    removing_ids = eval(row["Removing_ids"])
    removing_ids.each do |id|
      Brand.where(account_id: id).update_all(account_id: row['Retaining_id'])
      ClientVital.where(account_id: id).update_all(account_id: row['Retaining_id'])
      Campaign.where(account_id: id).update_all(account_id: row['Retaining_id'])
      User.where(organisation_id: id, organisation_type: 'Account').update_all(organisation_id: row['Retaining_id'])
      ClientApprover.where(client_id: id).update_all(client_id: row['Retaining_id'])
      Account.where(parent_client_id: id).update_all(parent_client_id: row['Retaining_id'])
      ClientAdditionalPerson.where(account_id: id).update_all(account_id: row['Retaining_id'])
    end
  end
end
