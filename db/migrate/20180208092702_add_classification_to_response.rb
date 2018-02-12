class AddClassificationToResponse < ActiveRecord::Migration[5.1]
  def change
    add_reference :responses, :classification, index: true
  end
end
