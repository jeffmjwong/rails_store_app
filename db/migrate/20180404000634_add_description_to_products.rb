class AddDescriptionToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :description, :text
    add_column :products, :photo, :string
    add_column :products, :stockvolume, :integer
    add_column :products, :unitprice, :float
  end
end
