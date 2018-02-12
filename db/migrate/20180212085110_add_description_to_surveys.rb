class AddDescriptionToSurveys < ActiveRecord::Migration[5.1]
  def change
    add_column :surveys, :description, :text
  end
end
