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


  # 菜单选中样式
  $(document).on 'click', '.menu.js a.item', (e) ->
    e.preventDefault()
    _$this = $(this)
    _$menu = _$this.closest('.menu')

    # 激活 menu 按钮样式
    _$menu.find('a.item').removeClass('active')
    _$this.addClass('active')

    # 显示对应 menu 面板
    _$menuContent = _$menu.next('.menu.content')
    _$menuContent.find('.menu-pane').hide()
    $(_$this.data('for')).fadeIn()


  # 分页ajax
  $(document).on 'click', '.pagination.remote a', (e) ->
    e.preventDefault()
    $.get(@href).done (resp) =>
      $(this).closest('.remote').parent().html(resp)