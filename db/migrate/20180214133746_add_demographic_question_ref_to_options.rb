class AddDemographicQuestionRefToOptions < ActiveRecord::Migration[5.1]
  def change
    add_reference :options, :demographic_question, foreign_key: true
  end
end
