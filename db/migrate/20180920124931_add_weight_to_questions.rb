class AddWeightToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :weight, :float, default: 0.0
  end
end
