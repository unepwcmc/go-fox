class AddUuidToSurveys < ActiveRecord::Migration[5.1]
  def change
    add_column :surveys, :uuid, :string, null: false
    add_index :surveys, :uuid, unique: true
  end
end
