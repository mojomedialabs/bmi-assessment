#= require jquery
#= require jquery-ui
#= require jquery_ujs
#= require_self

$.fn.fadingLinks = (color, duration = 500) ->
  @each ->
    original = $(this).css("color")
    $(this).mouseover ->
      $(this).stop().animate color: color, duration

    $(this).mouseout ->
      $(this).stop().animate color: original, duration
