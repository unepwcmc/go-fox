class CreateResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :responses do |t|
      t.references :survey, foreign_key: true
      t.string :ip_address
      t.string :langauge
      t.string :uuid

      t.timestamps
    end
  end
end
