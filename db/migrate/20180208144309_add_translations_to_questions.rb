class AddTranslationsToQuestions < ActiveRecord::Migration[5.1]
  def up
    Question.create_translation_table!({text: :string}, {migrate_data: true})
  end

  def down
    Question.drop_translation_table! migrate_date: true
  end
end
