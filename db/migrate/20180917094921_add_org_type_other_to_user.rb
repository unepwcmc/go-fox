class AddOrgTypeOtherToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :org_type_other, :string, default: ""
  end
end
