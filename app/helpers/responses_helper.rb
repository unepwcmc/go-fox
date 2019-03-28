module ResponsesHelper
  def scale_options_for_answers
    ["Strongly Disagree", "Disagree", "Slightly Disagree", "Neither Agree nor Disagree", "Slightly Agree", "Agree", "Strongly Agree"]
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

    question_type_demographic = answer_form.object.question.kind_of? DemographicQuestion
    validation = question_type_demographic ? answer_form.object.question.validation : {
      required: true
    }.to_json

    attributes = {
      ':validate': 'props.validate',
      ':validation_rules': validation,
      'name': "response[answers_attributes][#{answer_form.index}][raw]",
      ':index': answer_form.index,
      ':options': options,
      ':scale': scale
    }

    content_tag(field_type, '', attributes)
  end

  def is_mandatory question
    ( 
      question.is_a?(Question) ||
      question.is_a?(CustomisedQuestion) ||
      question.is_a?(DemographicQuestion) && question.is_required
    )
  end

  def response_score response
    score = ""

    (1..3).each do |n|
      score += "F#{n}: #{number_with_precision(response.send("f#{n}_score"), precision: 2)}"
      score += '<br>' if n < 3
    end

    score.html_safe
  end
end
