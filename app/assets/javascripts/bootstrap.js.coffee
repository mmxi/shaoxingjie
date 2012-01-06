$ ->
  $("body > .topbar").scrollSpy()
$ ->
  $(".tabs").tabs()
$ ->
  $("a[rel=twipsy]").twipsy live: true
$ ->
  $("a[rel=popover]").popover offset: 10
$ ->
  $(".topbar-wrapper").dropdown()
$ ->
  $(".alert-message").alert()
$ ->
  btn = $("#loginbtn").click ->
    btn.button('loading')
$ ->
  domModal = $(".modal").modal(
    backdrop: true
    closeOnEscape: true
  )
  $(".open-modal").click ->
    domModal.toggle()  
