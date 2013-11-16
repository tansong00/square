$ ->
  $(document).on 'click', '#for_taskbar', ->
    $('#taskbar').sidebar('toggle')

  $(document).on 'click', '#for_task-page', ->
    if (_$dom = $('#picture-js')).length > 0
      $.post $(@).data('url'), id: _$dom.data('id'), (resp) ->
        $('#taskalbum-container').append(resp)
    else
      $.$pop('请在相册页面中使用该功能~')

  $(document).on 'click', '#for_task-sku', ->
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
        $.post $(@).data('url'), sku: sku, (resp) ->
          $('#taskalbum-container').append(resp)
