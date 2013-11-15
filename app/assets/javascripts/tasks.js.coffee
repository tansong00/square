$ ->
  $(document).on 'click', '#4taskbar', ->
    $('#taskbar').sidebar('toggle')

  $(document).on 'click', '#4task-page', ->
    if (_$dom = $('#picture-js')).length > 0
      $.$pop('ok')
    else
      $.$pop('请在相册页面中使用该功能~')

  $(document).on 'click', '#4task-sku', ->
    $("""
      <div class="ui large form" style="width: 400px; padding: 30px 60px;">
        <div class="field">
          <label>请输入SKU</label>
          <input type="text" name="sku" id="sku4task">
        </div>
        <p class="square center">
          <span class="square button small floating right cancel w">取消</span>
          <span class="square button small floating right ok">确认</span>
        </p>
      </div>
      """)
    .$pop()