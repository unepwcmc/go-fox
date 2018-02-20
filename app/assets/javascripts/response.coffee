$(document).on 'turbolinks:load', ->
  $(document).find('select').not('.select2-hidden-accessible').select2()
  return
