$(document).ready ->
  $('.alert-message').alert()
  $('.topbar').dropdown()
  jQuery("abbr.timeago").timeago()

  if jQuery.browser.msie == true
    $('.input_text,textarea').bind 'focus', ->
      $(this).addClass('ieFocus')
    $('.input_text,textarea').bind 'blur', ->
      $(this).removeClass('ieFocus')
