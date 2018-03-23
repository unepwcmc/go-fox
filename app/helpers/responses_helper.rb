module ResponsesHelper
  def scale_options_for_answers
    ["Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"]
  end

  def getFormField answer_form
    fieldType = answer_form.object.question.question_type.downcase.gsub(' ', '-')
    scale = false

    case fieldType
      when 'scale'
        fieldType = 'radio-buttons'
        options = scale_options_for_answers.to_json
        scale = true
  
      when 'free-text'
        fieldType = 'text-input'
        options = ''.to_json

      when 'radio-button'
        fieldType = 'radio-buttons'
        options = answer_form.object.question.options.to_json

      when 'checkbox'
        fieldType = 'checkboxes'
        options = answer_form.object.question.options.to_json

      when 'select-box'
        options = answer_form.object.question.options.to_json

      when 'multiple-select-box'
        options = answer_form.object.question.options.to_json
    end

    attributes = {
      ':validate': 'props.validate',
      'name': "response[answers_attributes][#{answer_form.index}][raw]",
      ':index': answer_form.index,
      ':options': options,
      ':scale': scale
    }

    content_tag(fieldType, '', attributes)
  end
end
