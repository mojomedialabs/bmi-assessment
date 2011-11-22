#= require jquery
#= require jquery-ui
#= require jquery_ujs
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
    $.post($(this)[0].form.action, { question_id: $(this)[0].name, answer_id: $(this)[0].value }, null, "script")
  $(".answer label[for='answer_id']").click ->
    $(this).prev().click()