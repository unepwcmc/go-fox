class RemoveDemographicQuestionIdFromOption < ActiveRecord::Migration[5.1]
  def change
    remove_column :options, :demographic_question_id
  end
end
