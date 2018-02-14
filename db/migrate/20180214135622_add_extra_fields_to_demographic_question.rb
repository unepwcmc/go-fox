class AddExtraFieldsToDemographicQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :demographic_questions, :type, :string
    add_column :demographic_questions, :validation, :jsonb
  end
end
