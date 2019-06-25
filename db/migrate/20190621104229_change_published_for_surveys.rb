class ChangePublishedForSurveys < ActiveRecord::Migration[5.1]
  def change
    change_column_default :surveys, :published, :true
  end
end
