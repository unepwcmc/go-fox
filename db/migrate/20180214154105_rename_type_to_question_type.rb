class RenameTypeToQuestionType < ActiveRecord::Migration[5.1]
  def change
    rename_column :demographic_questions, :type, :question_type
  end
end
