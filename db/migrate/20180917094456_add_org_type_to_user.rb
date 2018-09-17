class AddOrgTypeToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :org_type, :integer, default: 1
  end
end
