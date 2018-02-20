$(document).on 'turbolinks:load', ->
  $(document).find('.js-example-placeholder-multiple').select2({
    allowClear: true,
    placeholder: "Select an option"
  });
  return
