class AddTranslationsToClassifications < ActiveRecord::Migration[5.1]
  def change
    # def up
    #   I18n.with_locale(:en) do
    #     Classification.create_translation_table!({
    #                                               name: :string,
    #                                               description: :text,
    #                                               results_description: :text
    #                                              }, {
    #                                               migrate_data: true
    #                                              })
    #   end
    # end
    #
    # def down
    #   Classification.drop_translation_table! migrate_date: true
    # end

    def up
      I18n.with_locale(:en) do
        Classification.create_translation_table!({name: :string}, {migrate_data: true})
      end
    end

    def down
      Classification.drop_translation_table! migrate_date: true
    end
  end
end
