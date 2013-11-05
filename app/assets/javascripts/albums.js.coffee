sidebar = ->
  if !!$('#album-js').length
    $('#bupload-bar').bind 'click', ->
      $('#upload-bar').sidebar('toggle')

$(document).ready(sidebar);
$(document).on('page:load', sidebar);