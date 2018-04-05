class AddVisibilityToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :visibility, :boolean
  end
end
