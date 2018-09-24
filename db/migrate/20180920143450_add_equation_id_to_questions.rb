class AddEquationIdToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :equation_id, :integer, default: nil
  end
end
