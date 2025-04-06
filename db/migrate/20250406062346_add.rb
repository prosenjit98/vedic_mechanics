class Add < ActiveRecord::Migration[7.1]
  def change
    add_column :contacts, :phone_number, :string
    add_column :contacts, :country_code, :string
  end
end
