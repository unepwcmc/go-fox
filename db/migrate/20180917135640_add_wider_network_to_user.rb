class AddWiderNetworkToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :wider_network, :boolean, default: true
  end
end
