#= require ./jquery.iframe-transport
#= require ./jquery.ui.widget
#= require ./load-image
#= require ./canvas-to-blob.min
#= require ./jquery.blueimp-gallery.min
#= require ./jquery.fileupload
#= require ./jquery.fileupload-process
#= require ./jquery.fileupload-image
#= require_self


fileSize = (size) ->
  kb = size / 1024
  if kb < 600
    "#{decimal(kb, 2)} KB"
  else
    mb = kb / 1024
    "#{decimal(mb, 2)} MB"

decimal = (num, v) ->
  vv = Math.pow(10,v)
  Math.round(num*vv)/vv

window.UploadUtils = {
  fileSize: fileSize
  decimal: decimal
}