module ResponsesHelper
  def scale_options_for_answers
    ["Strongly Disagree", "Disagree", "Slightly Disagree", "Neutral", "Slightly Agree", "Agree", "Strongly Agree"]
  end

  def get_form_field answer_form
    field_type = answer_form.object.question.question_type.downcase.gsub(' ', '-')
    scale = false

    case field_type
      when 'scale'
        field_type = 'radio-buttons'
        options = scale_options_for_answers.to_json
        scale = true

      when 'free-text'
        field_type = 'text-input'
        options = ''.to_json

      when 'radio-button'
        field_type = 'radio-buttons'
        options = answer_form.object.question.options.to_json

      when 'checkbox'
        field_type = 'checkboxes'
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

    content_tag(field_type, '', attributes)
  end
end
