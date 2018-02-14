# == Schema Information
#
# Table name: options
#
#  id                      :integer          not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  demographic_question_id :integer
#
# Indexes
#
#  index_options_on_demographic_question_id  (demographic_question_id)
#
# Foreign Keys
#
#  fk_rails_...  (demographic_question_id => demographic_questions.id)
#

require 'test_helper'

class OptionTest < ActiveSupport::TestCase
  test "saving an option" do
    option = FactoryBot.build(:option, text: "Select box")
    assert option.save, "Option was not saved"
  end
end
