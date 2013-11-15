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

picture = ->
  if $('#picture-js').length
    $('#files-container').perfectScrollbar(wheelSpeed: 25)

    $('#fileupload').fileupload
      sequentialUploads: true
      formData: (form) ->
        form.serializeArray()

    $('#bupload').bind 'click', ->
      $('#pic-gallery-wrap').slideToggle()

    $('#bedit').bind 'click', ->
      _$this = $(@)
      $.get _$this.data('url'), (resp) ->
        $(resp).$pop()

    $('#bremove').bind 'click', (e) ->
      e.preventDefault()
      _$cover = $('.cover')
      if _$cover.transition('is looping')[0]
        _$cover.transition('remove looping')
        _$cover.removeClass().addClass('square center cover')
      else
        _$cover
        .transition('set looping')
        .transition('bounce', '2000ms')

    $('#pic-gallery').on 'click', '.cover.looping', (e) ->
      _$cover = $(@)
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
      .on 'click', '.cancel', ->
          $.$pop(null, 'out')

$(document).ready(picture);
$(document).on('page:load', picture);