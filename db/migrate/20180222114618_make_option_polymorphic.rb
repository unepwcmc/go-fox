class MakeOptionPolymorphic < ActiveRecord::Migration[5.1]
  def change
    add_column :options, :optionable_id, :integer
    add_column :options, :optionable_type, :string

    add_index :options, [:optionable_id, :optionable_type]
  end
end
