$ ->
  # 登录
  $(document).on 'click', '#for_login', ->
    _args = arguments
    _this = this
    $.get '/sessions/new', (resp) ->
      _$pane = $(resp).css(width: "300px", padding: '20px 60px').$pop()
      _$pane.find('input[name="username"]').focus()
      _$pane.on 'ok', ->
        _$form = _$pane.find('form')
        def = $.post _$form[0].action, _$form.serialize()
        def.done (resp) ->
          $('#main-topbar').replaceWith(resp)
        def.fail (resp) ->
          $.$pop '登录失败'
          _args.callee.apply(_this, _args)

  # 气泡颜色选择
  $(document).on 'click', '.bubble-select', ->
    _$this = $(this)
    _$this.siblings('.bubble-select').removeClass('checked')
    _$this.removeClass('checked').addClass('checked')
    $('#user_bubble_color').val _$this.data('color')


  # 用户面板弹出
  $userPaneHtml = null;
  $(document).on 'click', '#logged_me', (e) ->
    e.preventDefault()
    if userPaneHtml?
      $userPaneHtml = $(userPaneHtml)
      $userPaneHtml.$pop()
    else
      $.get(@href)
      .done (resp) ->
        $userPaneHtml = $(resp)
        $userPaneHtml.$pop()

  # 更新用户信息
  $(document).on 'click', '#for_update_userinfo', (e) ->
    e.preventDefault()
    _$this = $(this)
    _$form = _$this.closest('form')
    $.post(_$form[0].action, _$form.serialize())
    .done (resp) ->
        $.$pop(null, 'out')
        $.$pop(resp)
        $userPaneHtml = null;
    .fail (resp) ->
        $.$pop(null, 'out')
        $.$pop(resp.responseText)
        $('#logged_me').trigger('click')

  # 获取用户留言列表
  $(document).on 'click', '#for_usercomments', (e) ->
    unless (_$c = $('#usercomments')).children().length
      $.get(_$c.data('resource'))
      .done (resp) ->
        _$c.html resp