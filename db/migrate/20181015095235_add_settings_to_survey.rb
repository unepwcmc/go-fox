class AddSettingsToSurvey < ActiveRecord::Migration[5.1]
  def change
    add_column :surveys, :settings, :jsonb, default: {}
  end
end
