$ ->
  $(document).on 'click', '#for_login', ->
    _args = arguments
    _this = this
    $.get '/sessions/new', (resp) ->
      _$pane = $(resp).css(width: "300px", padding: '20px 60px').$pop()
      _$pane.on 'ok', ->
        _$form = _$pane.find('form')
        def = $.post _$form[0].action, _$form.serialize()
        def.done (resp) ->
          $('#main-topbar').replaceWith(resp)
        def.fail (resp) ->
          $.$pop '登录失败'
          _args.callee.apply(_this, _args)