class CreateSurveys < ActiveRecord::Migration[5.1]
  def change
    create_table :surveys do |t|
      t.string :name
      t.boolean :published
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
