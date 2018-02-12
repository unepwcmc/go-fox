class AddResultsToResponses < ActiveRecord::Migration[5.1]
  def change
    add_column :responses, :x_axis_scaled, :float
    add_column :responses, :y_axis_scaled, :float
    add_column :responses, :z_axis_scaled, :float
  end
end
