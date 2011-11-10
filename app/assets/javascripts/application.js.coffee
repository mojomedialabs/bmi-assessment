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
