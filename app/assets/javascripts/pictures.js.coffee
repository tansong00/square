@fileSize = (size) ->
  kb = size / 1024
  if kb < 600
    "#{decimal(kb, 2)} KB"
  else
    mb = kb / 1024
    "#{decimal(mb, 2)} MB"

@decimal = (num, v) ->
  vv = Math.pow(10,v)
  Math.round(num*vv)/vv

$ ->
  # 弹出上传面板
  $(document).on 'click', '#bupload', ->
    $('#pic-gallery-wrap').slideToggle()

  # 弹出编辑面板
  $(document).on 'click', '#bedit', ->
    _$this = $(@)
    $.get _$this.data('url'), (resp) ->
      $(resp).$pop()

  # 进入可删除状态
  $(document).on 'click', '#bremove', (e) ->
    e.preventDefault()
    _$pic_gallery = $('#pic-gallery')
    if _$pic_gallery.hasClass('removeable')
      _$pic_gallery.removeClass('removeable')
      $('#pic-gallery-signal').removeClass()
    else
      _$pic_gallery.removeClass().addClass('ui grid stackable five column clearfix removeable')
      $('#pic-gallery-signal').removeClass().addClass('show remove')

  # 删除单张图片
  $(document).on 'click', '#pic-gallery.removeable .cover', ->
    _$cover = $(@)
    _$taskbar = $('#taskbar')
    unless _$taskbar.length and _$taskbar.sidebar('is open')
      $("""
        <p class="square center">是否删除？</p>
        <p class="square center">
        <span class="cancel square button small w">取消</span>
        <span class="ok square button small">确定</span>
        </p>""")
      .$pop()
      .on 'click', '.ok', ->
          $.post _$cover.data('url'), {_method: 'delete'}, (resp) ->
            $.$pop(null, 'out')
            _$cover.closest('.column').remove()

  # 用户授权
  $(document).on 'click', '#bauthorize', ->
    _$this = $(this)
    _args = arguments
    _this = this
    url = _$this.data('url')
    $.get url, (resp) ->
      _$pane = $(resp).$pop()
      .on 'ok', ->
        $.post(url, _$pane.find('form').serialize())
        .done (resp) ->
          $.$pop(resp)
        .fail (resp) ->
          $.$pop(resp.responseText)
          _args.callee.call(_this, _args)

  # 进入下载状态
  $(document).on 'click', '#bdownload', (e) ->
    e.preventDefault()
    _$pic_gallery = $('#pic-gallery')
    if _$pic_gallery.hasClass('downloadable')
      _$pic_gallery.removeClass('downloadable')
      $('#pic-gallery-signal').removeClass()
    else
      _$pic_gallery.removeClass().addClass('ui grid stackable five column clearfix downloadable')
      $('#pic-gallery-signal').removeClass().addClass('show download')

  # 下载单张图片
  $(document).on 'click', '#pic-gallery.downloadable .cover', ->
    _$this = $(this)
    pid = _$this.data('id')
    url = $('#bdownload').data('url')
    window.location.href = "#{url}?pid=#{pid}"


picture = ->
  if $('#picture-js').length
    $('#files-container').perfectScrollbar(wheelSpeed: 25)

    $('#fileupload').fileupload
      sequentialUploads: false
      formData: (form) ->
        form.serializeArray()

$(document).ready(picture);
$(document).on('page:load', picture);