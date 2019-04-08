class AddWiderNetworkDetailsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :wider_network_details, :string, default: ""
  end
end
