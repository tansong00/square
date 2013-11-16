$ ->
  $(document).on 'click', '#for_login', ->
    $.get '/sessions/new', (resp) ->
      _$pane = $(resp).css(width: "300px", padding: '20px 60px').$pop()