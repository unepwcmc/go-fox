class ChangeAxisNamesForResponses < ActiveRecord::Migration[5.1]
  def change
    rename_column :responses, :x_score, :f1_score
    rename_column :responses, :y_score, :f2_score
    rename_column :responses, :z_score, :f3_score
  end
end
