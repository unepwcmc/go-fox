$(document).on 'turbolinks:load', ->
  $(document).find('select').select2( {
    allowClear: true,
    placeholder: "Select an option"
  });
  return
