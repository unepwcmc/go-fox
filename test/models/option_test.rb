# == Schema Information
#
# Table name: options
#
#  id                      :integer          not null, primary key
#  text                    :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  demographic_question_id :integer
#  optionable_id           :integer
#  optionable_type         :string
#
# Indexes
#
#  index_options_on_demographic_question_id            (demographic_question_id)
#  index_options_on_optionable_id_and_optionable_type  (optionable_id,optionable_type)
#
# Foreign Keys
#
#  fk_rails_...  (demographic_question_id => demographic_questions.id)
#

require 'test_helper'

class OptionTest < ActiveSupport::TestCase
  test "saving an option" do
    dq = FactoryBot.build(:demographic_question)
    option = FactoryBot.build(:option, demographic_question: dq)
    assert option.save, "Option was not saved"
  end
end
