class AddAxisNameToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :axis_name, :string, default: ""
  end
end
