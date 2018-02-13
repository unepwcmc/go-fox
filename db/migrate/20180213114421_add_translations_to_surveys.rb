class AddTranslationsToSurveys < ActiveRecord::Migration[5.1]
  def up
    I18n.with_locale(:en) do
      Survey.create_translation_table!({
        name: :string,
        description: :text
      }, {migrate_data: true})
    end
  end

  def down
    Survey.drop_translation_table! migrate_date: true
  end
end
