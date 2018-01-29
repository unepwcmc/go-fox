class AddUuidToSurveys < ActiveRecord::Migration[5.1]
  def change
    add_column :surveys, :uuid, :string, null: false
  end
end
