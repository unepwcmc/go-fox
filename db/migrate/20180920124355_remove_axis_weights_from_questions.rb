class RemoveAxisWeightsFromQuestions < ActiveRecord::Migration[5.1]
  def change
    remove_column :questions, :x_weight
    remove_column :questions, :y_weight
    remove_column :questions, :z_weight
  end
end
