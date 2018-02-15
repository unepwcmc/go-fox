class AddTranslationsToOptions < ActiveRecord::Migration[5.1]
  def up
    I18n.with_locale(:en) do
      Option.create_translation_table!({text: :string}, {migrate_data: true})
    end
  end

  def down
    Option.drop_translation_table! migrate_data: true
  end
end
