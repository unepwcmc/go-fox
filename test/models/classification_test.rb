# == Schema Information
#
# Table name: classifications
#
#  id                  :integer          not null, primary key
#  name                :string
#  description         :text
#  results_description :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class ClassificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
