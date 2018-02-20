class CreateCustomisedQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :customised_questions do |t|
      t.references :demographic_question, foreign_key: true
      t.references :survey, foreign_key: true
      t.string :text

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        I18n.with_locale(:en) do
          CustomisedQuestion.create_translation_table!({text: :string}, {migrate_data: true})
        end
      end

      dir.down do
        CustomisedQuestion.drop_translation_table! migrate_data: true
      end
    end
  end
end
