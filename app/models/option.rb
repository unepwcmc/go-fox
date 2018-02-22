# == Schema Information
#
# Table name: options
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  optionable_id   :integer
#  optionable_type :string
#
# Indexes
#
#  index_options_on_optionable_id_and_optionable_type  (optionable_id,optionable_type)
#

class Option < ApplicationRecord
  belongs_to :optionable, polymorphic: true

  translates :text
  accepts_nested_attributes_for :translations

  def question
    optionable
  end
end
