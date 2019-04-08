class AddOrgTypeToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :org_type, :string, null: false, default: ""
  end
end
