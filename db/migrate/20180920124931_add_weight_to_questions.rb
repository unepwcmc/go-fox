class AddWeightToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :weight, :float, default: nil
  end
end
