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
      $('#pic-uploader').toggle()
      $('#pic-gallery-wrap').slideToggle()

$(document).ready(picture);
$(document).on('page:load', picture);