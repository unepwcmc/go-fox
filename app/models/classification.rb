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

class Classification < ApplicationRecord
  has_many :responses

  translates :name#, :description, :results_description
  accepts_nested_attributes_for :translations
end
