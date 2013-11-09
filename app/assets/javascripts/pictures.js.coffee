fileSize = window.UploadUtils.fileSize
decimal  = window.UploadUtils.decimal

fileList = {}

itemHtml = (file) ->
  """
  <div class="item">
    <div class="ui grid">
      <div class="one wide column">
        <div class="ui avatar image"></div>
      </div>
      <div class="ten wide column">
        <div class="content">
          <div class="square txt blod grey">#{file.name}</div>
        </div>
      </div>
      <div class="three wide column">
        <span class="square txt grey">#{fileSize(file.size)}</span>
      </div>
      <div class="two wide column square center">
        <span class="tiny red ui button cancel-upload" data-name="#{file.name}">取消</span>
      </div>
    </div>
  </div>
  """


changeFiles = (e, data) ->
  for file in data.files
    ((file) ->
      loadImage file, (img) ->
        $(itemHtml(file)).appendTo('#files-container').find('.image')[0].appendChild(img)
      .onerror = ->
        $('#files-container').append itemHtml(file)
    )(file)


picture = ->
  if $('#picture-js').length
    $('#files-container').perfectScrollbar(wheelSpeed: 25)

    _$fileupload = $('#fileupload').fileupload
      acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i
      autoUpload: false
      change: changeFiles
      drop: changeFiles
      add: (e, data) ->
        file = data.files[0]
        fileList[file.name] = data


    jqXHR = null

    # 开始上传
    _$fileupload.on 'click', '.start-upload', ->
      fileArr = []
      for name, file of fileList
        fileArr.push file
      jqXHR = $('#fileupload').fileupload('send', {files: fileArr})

    # 停止上传
    _$fileupload.on 'click', '.stop-upload', ->
      jqXHR?.abort()

    # 取消单个
    _$fileupload.on 'click', '.cancel-upload', ->
      _$this = $(@)
      _$item = _$this.closest('.item')
      delete fileList[_$this.data('name')]
      _$item.fadeOut -> _$item.remove();



$(document).ready(picture);
$(document).on('page:load', picture);