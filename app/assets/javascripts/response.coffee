$(document).on 'turbolinks:load', ->
  $(document).find('.js-select2').select2({
    allowClear: true,
    placeholder: "Select an option"
  });
  return
