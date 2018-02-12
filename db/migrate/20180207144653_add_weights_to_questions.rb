class AddWeightsToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :x_weight, :float
    add_column :questions, :y_weight, :float
    add_column :questions, :z_weight, :float
  end
end
