class AddMasterToSurveys < ActiveRecord::Migration[5.1]
  def change
    add_column :surveys, :master, :boolean, default: false
  end
end
