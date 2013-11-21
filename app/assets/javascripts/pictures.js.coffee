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
  $(document).on 'click', '#bupload', ->
    $('#pic-gallery-wrap').slideToggle()

  $(document).on 'click', '#bedit', ->
    _$this = $(@)
    $.get _$this.data('url'), (resp) ->
      $(resp).$pop()

  $(document).on 'click', '#bremove', (e) ->
    e.preventDefault()
    _$pic_gallery = $('#pic-gallery')
    if _$pic_gallery.hasClass('removeable')
      _$pic_gallery.removeClass('removeable')
      $('#pic-gallery-signal').removeClass()
    else
      _$pic_gallery.addClass('removeable')
      $('#pic-gallery-signal').removeClass().addClass('show remove')

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


picture = ->
  if $('#picture-js').length
    $('#files-container').perfectScrollbar(wheelSpeed: 25)

    $('#fileupload').fileupload
      sequentialUploads: false
      formData: (form) ->
        form.serializeArray()

$(document).ready(picture);
$(document).on('page:load', picture);