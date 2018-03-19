class AddLockedToSurveys < ActiveRecord::Migration[5.1]
  def change
    add_column :surveys, :locked, :boolean, default: false
  end
end
