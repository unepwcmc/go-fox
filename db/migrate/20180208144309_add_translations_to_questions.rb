class AddTranslationsToQuestions < ActiveRecord::Migration[5.1]
  def up
    I18n.with_locale(:en) do
      Question.create_translation_table!({text: :string}, {migrate_data: true})
    end
  end

  def down
    Question.drop_translation_table! migrate_date: true
  end
end
