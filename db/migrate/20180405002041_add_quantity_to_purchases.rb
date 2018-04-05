class AddQuantityToPurchases < ActiveRecord::Migration[5.1]
  def change
    add_column :purchases, :quantity, :integer
  end
end
