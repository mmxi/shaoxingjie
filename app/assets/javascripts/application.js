//= require jquery
//= require jquery-ui.min
//= require jquery_ujs
//= require jquery.timeago
//= require twitter/bootstrap
//= require bootstrap
//= require base

function dialog_message(message) {
  $('body').append('<div id="notice-message">' + message + '</div>');
  $("#notice-message").dialog({ closeText: '×', title: '消息', minHeight: '20'});
}
