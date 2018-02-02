class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.references :response, foreign_key: true
      t.jsonb :raw
      t.references :answerable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
