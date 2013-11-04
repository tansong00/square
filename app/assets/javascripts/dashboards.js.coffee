dropdown = ->
  $('.ui.dropdown').bind 'click', ->
    $(@).dropdown('toggle')

$(document).ready(dropdown);
$(document).on('page:load', dropdown);