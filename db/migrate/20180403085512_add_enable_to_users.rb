class AddEnableToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :enable, :boolean, default: true
  end
end
