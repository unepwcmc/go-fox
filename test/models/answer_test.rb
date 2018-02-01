# == Schema Information
#
# Table name: answers
#
#  id              :integer          not null, primary key
#  response_id     :integer
#  raw             :jsonb
#  answerable_type :string
#  answerable_id   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_answers_on_answerable_type_and_answerable_id  (answerable_type,answerable_id)
#  index_answers_on_response_id                        (response_id)
#
# Foreign Keys
#
#  fk_rails_...  (response_id => responses.id)
#

require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
