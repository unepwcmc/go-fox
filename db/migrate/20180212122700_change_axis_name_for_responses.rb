class ChangeAxisNameForResponses < ActiveRecord::Migration[5.1]
  def change
    rename_column :responses, :x_axis_scaled, :x_score
    rename_column :responses, :y_axis_scaled, :y_score
    rename_column :responses, :z_axis_scaled, :z_score
  end
end
