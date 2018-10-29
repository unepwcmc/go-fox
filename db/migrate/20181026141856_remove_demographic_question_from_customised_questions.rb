class RemoveDemographicQuestionFromCustomisedQuestions < ActiveRecord::Migration[5.1]
  def change
    remove_column :customised_questions, :demographic_question_id
  end
end
