class AddCustomisableToDemographicQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :demographic_questions, :customisable, :boolean, default: false
  end
end
