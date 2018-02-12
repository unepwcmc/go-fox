class CreateClassifications < ActiveRecord::Migration[5.1]
  def change
    create_table :classifications do |t|
      t.string :name
      t.text :description
      t.text :results_description

      t.timestamps
    end
  end
end
