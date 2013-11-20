$ ->
  $(document).on 'click', '#for_taskbar', ->
    if logged_in
      if $('#taskbar').length is 0
        $.get '/tasks/tmp', (resp) ->
          $(resp).appendTo('body').sidebar('show')
      else
        $('#taskbar').sidebar('toggle')
    else
      $('#for_login').trigger('click')

  $(document).on 'click', '#for_task-page', ->
    if (_$dom = $('#picture-js')).length > 0
      $.post('/tasks', id: _$dom.data('id'))
      .done((resp) -> $('#taskalbum-container').append(resp))
      .fail((resp) -> $.$pop(resp.responseText))
    else
      $.$pop('请在相册页面中使用该功能~')

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


  $(document).on 'click', '.remove_album', (e) ->
    _$this = $(@)
    $.post('/tasks/remove_album', {task_id: _$this.data('tid'), album_id: _$this.data('aid'), _method: 'delete'})
    .done (resp) ->
      $("#task-#{resp.tid}-album-#{resp.aid}").remove()
    .fail (resp) ->
      $.$pop(resp.responseText)

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