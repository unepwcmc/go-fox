# == Schema Information
#
# Table name: options
#
#  id         :integer          not null, primary key
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Option < ApplicationRecord
  translates :text
  accepts_nested_attributes_for :translations
end
