#= require jquery
#= require jquery-ui
#= require jquery_ujs
#= require results_graphs
#= require_self

$ ->
  $(".click-to-close").click ->
    $(this).fadeTo 400, 0, ->
      $(this).slideUp 400
  $.fn.fadingLinks = (color, duration = 500) ->
    @each ->
      original = $(this).css("color")
      $(this).mouseover ->
        $(this).stop().animate color: color, duration
      $(this).mouseout ->
        $(this).stop().animate color: original, duration
  $(".answer input[type='radio']").click ->
    $.post($(this)[0].form.action, { question_id: $(this)[0].name, answer_id: $(this)[0].value, client_id: $("#client_id").val() }, null, "script")
  $(".answer label[for='answer_id']").click ->
    $(this).prev().click()
  $("#user_email_address_confirmation").val $("#user_email_address").val()
  $("#user_email_address").keyup ->
    $("#user_email_address_confirmation").val ""
    $("#user_email_address_confrimation").attr "placeholder", $("#user_email_address").val()
  $("#user_password").keyup ->
    $("#user_password_confirmation").val ""