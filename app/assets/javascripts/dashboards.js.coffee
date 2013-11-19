$ ->
  $(document).on 'click', '.ui.dropdown', ->
    $(@).dropdown('toggle')

  $(document).on 'click', '.req_log', (e) ->
    unless logged_in
      e.preventDefault()
      e.stopPropagation()
      $('#for_login').trigger('click')

  $(document).on 'click', '#for_newattach', (e) ->
    e.preventDefault()
    $.get @href, (resp) -> $(resp).$pop()