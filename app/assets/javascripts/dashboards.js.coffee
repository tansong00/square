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
    if logged_in
      $.get @href, (resp) -> $(resp).$pop()
    else
      $('#for_login').trigger('click')


  Mousetrap.bind 'u', ->
    unless $('#pop_pane').length # 如果当前有弹窗，则忽略
      _$logged_me = $('#logged_me')
      if _$logged_me.length
        _$logged_me.trigger('click')
      else
        $('#for_login').trigger('click')

  Mousetrap.bind 'esc', (e) ->
    $.$pop(null, 'out') if $('#pop_pane').length