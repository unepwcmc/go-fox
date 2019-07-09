$(document).ready ->
  toggleQuestionAddLink = (questions) ->
    $("a.add-customised-question-option")
      .data('association-insertion-node', (link) ->
        return link.parent().find('#options-container')
      )

    if questions.length >= 3
      $('.add-customised-question').hide()
    else
      $('.add-customised-question').show()

  toggleOptionAddLink = (question) ->
    options = question.find('.customised-question__option.nested-fields')

    if options.length >= 10
      question.find('.add-customised-question-option').hide()
    else
      question.find('.add-customised-question-option').show() 

  toggleAddLinks = ->
    questions = $('.customised-question.nested-fields')

    toggleQuestionAddLink(questions)
    $.each(questions, -> toggleOptionAddLink($(this)))

  $(document).on 'cocoon:after-insert', ->
    toggleAddLinks()

  $(document).on 'cocoon:after-remove', ->
    toggleAddLinks()

  toggleAddLinks()

  $(document).find('.js-select2').select2({
    allowClear: true,
    placeholder: "Select an option"
  });
  return
