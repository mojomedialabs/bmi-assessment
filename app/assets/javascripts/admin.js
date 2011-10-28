//= require jquery
//= require jquery_ujs
//= require_self

$(document).ready(function(){
  $(".click-to-close").click(function() {
		$(this).fadeTo(400, 0, function () {
			$(this).slideUp(400);
		});
		return false;
	});

	if ($("#search").length) {
		if ($("#search").val().length > 0) {
			$("#search").focus();
		}
	}

	if (history && history.pushState) {
		$("#index-search").submit(function() {
			$.get(this.action, $(this).serialize(), null, "script");

			history.pushState(null, document.title, this.action + "?" + $(this).serialize());

			return false;
		});

		$("th a, .pagination a").live("click", function() {
			$.getScript(this.href);

			history.pushState(null, "", this.href);

			return false;
		});

		$(window).bind("popstate", function() {
			$.getScript(location.href);
		});
	}

	$(".check-all").click(function() {
		$(this).parent().parent().parent().parent().find("input[type='checkbox']").attr("checked", $(this).is(":checked"));
	});

	$("input:checkbox").click(function() {
		var buttonsChecked = $("input:checkbox:checked");

		if (buttonsChecked.length) {
			$("#edit-selected-button").removeAttr("disabled");
			$("#delete-selected-button").removeAttr("disabled");
		} else {
			$("#edit-selected-button").attr("disabled", "disabled");
			$("#delete-selected-button").attr("disabled", "disabled");
		}
	});

	$("#toggle-debug").click(function() {
		$("#debug-info").slideToggle();

		$(".toggle-debug-text").toggle();
	});

  /*function setChildrenDisplayOrder(selector) {
    console.log(selector);

    $(selector).children().each(function() {
      console.log(this);

      var fields = $(this).find("> .display-order > .display-order-field");

      console.log(fields);

      $.each(fields, function(index, value) {
        console.log(index);

        $(this).val(index);
      });
    });
  }*/

  function add_fields(link, association, content) {
    var newID = new Date().getTime();
    var regExp = new RegExp("new_" + association, "g");

    $(link).parent().insertBefore(content.replace(regExp, newID));
  }

  $(".remove img").click(function() {
    console.log($(this).parent().find(".remove-field"));

    $(this).parent().find(".remove-field").val("true");

    $(this).parent().parent().addClass("deleted-field");

    $(this).parent().parent().slideUp();

    updateDisplayOrders();
  });

  function updateDisplayOrders() {
    $(".section").not(".deleted-field").find("> .display-order > .display-order-field").not(".deleted-field").each(function(index, value) {
      $(this).val(index);
    });

    $(".section").each(function() {
      var fields = $(this).find(".question").not(".deleted-field").find("> .display-order > .display-order-field");

      $.each(fields, function(index, value) {
        $(this).val(index);
      });
    });

    $(".question").each(function() {
      var fields = $(this).find(".answer").not(".deleted-field").find("> .display-order > .display-order-field");

      $.each(fields, function(index, value) {
        $(this).val(index);
      });
    });
  }

  updateDisplayOrders();

  $(".display-order .increase-display-order").click(function() {
    var elementClass = $(this).parent().parent().attr("class");

    if ($(this).parent().parent().prev().hasClass(elementClass)) {
      $(this).parent().parent().insertBefore($(this).parent().parent().prev());
    }

    updateDisplayOrders();
  });

  $(".display-order .decrease-display-order").click(function() {
    var elementClass = $(this).parent().parent().attr("class");

    if ($(this).parent().parent().next().hasClass(elementClass)) {
      $(this).parent().parent().insertAfter($(this).parent().parent().next());
    }

    updateDisplayOrders();
  });
});
