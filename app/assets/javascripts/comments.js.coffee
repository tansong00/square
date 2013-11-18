$ ->
  $(document).on 'submit', '#new_comment', (e) ->
    unless logged_in
      $('#btn4login').trigger('click')
      return e.preventDefault()

