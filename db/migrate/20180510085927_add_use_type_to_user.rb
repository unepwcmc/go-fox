class AddUseTypeToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :use_type, :integer, default: 0
  end
end
