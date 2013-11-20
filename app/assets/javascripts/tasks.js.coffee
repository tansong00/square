$ ->
  # 是否可以为任务添加单个图片
  canAddPic = false

  # 添加单图
  $(document).on 'click', '.add_pic', ->
    _$this = $(this)
    if !_$this.is('.looping') and canAddPic

      # 拷贝图片副本
      _$img = _$this.find('img')
      offset = _$img.offset()
      _$img2 = _$img.clone(true).appendTo('body').css(display: 'none', position: 'absolute',  top: offset.top + 'px', left: offset.left + 'px', zIndex: 10001)

      # 计算目标位置
      aid = $('#picture-js').data('id')
      _$ta = $("#ta-#{aid}")
      offset2 = _$ta.find('img').offset()

      # 开始位移
      _$img2.show()
        .animate top: offset.top - 30 + 'px', opacity: 0.95, ->
          _$img2.animate top: offset2.top + 'px', left: offset2.left + 'px', opacity: 0.6, 'slow', ->
            _$img2.animate opacity: 0, ->
              _$img2.remove()
              $.post(_$ta.data('picurl'), aid: aid, _method: 'patch', pid: _$img.data('pid'))
              .done (resp) ->
                  console.log(resp)
              .fail (resp) ->
                  $.$pop(resp.responseText)


  # 弹出任务栏
  $(document).on 'click', '#for_taskbar', ->
    if logged_in
      if $('#taskbar').length is 0
        $.get '/tasks/tmp', (resp) ->
          $(resp).appendTo('body').sidebar('show')
          canAddPic = true
      else
        _$tb = $('#taskbar').sidebar('toggle')
        canAddPic = _$tb.sidebar('is open')
    else
      $('#for_login').trigger('click')

  # 加入当前页
  $(document).on 'click', '#for_task-page', ->
    if (_$dom = $('#picture-js')).length > 0
      $.post('/tasks', id: _$dom.data('id'))
      .done((resp) -> $('#taskalbum-container').append(resp))
      .fail((resp) -> $.$pop(resp.responseText))
    else
      $.$pop('请在相册页面中使用该功能~')


  # 根据 SKU 查找相册
  $(document).on 'click', '#for_task-sku', ->
    _this = this
    _args = arguments
    _$pane = $("""
             <div class="ui large form" style="width: 400px; padding: 30px 60px;">
               <div class="field">
                 <label>请输入SKU</label>
                 <input type="text" name="sku" id="sku4task">
               </div>
               <p class="square center">
                 <span class="square button small cancel w">取消</span>
                 <span class="square button small ok">确认</span>
               </p>
             </div>
             """).$pop()

    _$pane.on 'ok', =>
      sku = _$pane.find('#sku4task').val()
      unless /^\s*$/.test sku
        $.post('/tasks', sku: sku)
        .done((resp) -> $('#taskalbum-container').append(resp))
        .fail (resp) ->
          $.$pop(resp.responseText)
          _args.callee.apply(_this, _args)


  # 移除相册
  $(document).on 'click', '.remove_album', (e) ->
    _$this = $(@)
    $.post('/tasks/remove_album', {task_id: _$this.data('tid'), album_id: _$this.data('aid'), _method: 'delete'})
    .done (resp) ->
      $("#ta-#{resp.aid}").remove()
    .fail (resp) ->
      $.$pop(resp.responseText)

  # 发布任务
  $(document).on 'click', '#pub_task', (e) ->
    _this = this
    _args = arguments
    url = $(@).data('url')
    $.get(url)
    .done (resp) ->
        _$pane = $(resp).$pop()
        .on 'ok', ->
            $.post(url, _$pane.find('form').serialize())
            .done (resp) ->
                setTimeout (->
                  $.$pop(resp)
                  $('#taskbar').remove()
                ), 800
                $('#taskbar').sidebar('hide')
            .fail (resp) ->
              $.$pop(resp.responseText)
              _args.callee.apply(_this, _args)
    .fail((resp) -> $.$pop(resp) )