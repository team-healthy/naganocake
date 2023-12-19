class RenameAdressColumnToOrders < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :adress, :address
  end
end
