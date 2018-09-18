class AddWiderNetworkToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :wider_network, :boolean, null: false, default: false
  end
end
