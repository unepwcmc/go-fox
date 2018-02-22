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

class Option < ApplicationRecord
  belongs_to :demographic_question

  translates :text
  accepts_nested_attributes_for :translations
end
