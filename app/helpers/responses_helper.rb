module ResponsesHelper
  def scale_options
    ["Strongly Disagree", "Disagree", "Slightly Disagree", "Neither Agree nor Disagree", "Slightly Agree", "Agree", "Strongly Agree"]
  end

  def map_answers options
    options.map do |option|
      {
        name: option,
        text: I18n.t("questions_options.#{option}", default: 'default')
      }
    end.to_json
  end

  def options_for_answers options
    if options.is_a?(ActiveRecord::Associations::CollectionProxy) && options.first.has_attribute?(:text)
      options = options.reload.pluck(:text) 
    end

    return options.to_json if !options.kind_of?(Array)

    map_answers(options)
  end

  def get_form_field answer_form
    field_type = answer_form.object.question.question_type.downcase.gsub(' ', '-')
    scale = false

    case field_type
      when 'scale'
        field_type = 'radio-buttons'
        validation_message = I18n.t('validation.select_option')
        options = scale_options
        scale = true

      when 'free-text'
        field_type = 'text-input'
        options = ''

      when 'radio-button'
        field_type = 'radio-buttons'
        validation_message = I18n.t('validation.select_option')
        options = answer_form.object.question.options

      when 'checkbox'
        field_type = 'checkboxes'
        validation_message = I18n.t('validation.select_at_least_one')
        options = answer_form.object.question.options

      when 'select-box'
        validation_message = I18n.t('validation.select_option')
        options = answer_form.object.question.options

      when 'multiple-select-box'
        validation_message = I18n.t('validation.select_at_least_one')
        options = answer_form.object.question.options
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
      ':options': options_for_answers(options),
      ':scale': scale
    }

    attributes['validation-message'] = validation_message if validation_message
    
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
