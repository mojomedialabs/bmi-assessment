//= require jquery
//= require jquery_ujs
//= require_self

$(function(){
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

  $(".remove img").live("click", function() {
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

  $(".display-order .increase-display-order").live("click", function() {
    var element = $(this).parent().parent();

    var elementClass = element.attr("class");

    var elementHiddenField = element.next();

    var previousElement = element.prev().prev();

    if (previousElement.hasClass(elementClass)) {
      element.insertBefore(previousElement);
      elementHiddenField.insertAfter(element);
    }

    updateDisplayOrders();
  });

  $(".display-order .decrease-display-order").live("click", function() {
    var element = $(this).parent().parent();

    var elementClass = element.attr("class");

    var elementHiddenField = element.next();

    var nextElement = element.next().next();

    if (nextElement.hasClass(elementClass)) {
      element.insertAfter(nextElement.next());
      elementHiddenField.insertAfter(element);
    }

    //if ($(this).parent().parent().next().next().hasClass(elementClass)) {
      //$(this).parent().parent().insertAfter($(this).parent().parent().next());
    //}

    updateDisplayOrders();
  });

  $("#assessment-form").submit(function(event) {
    $(".result").each(function() {
        if (parseInt($(this).find(".result-bottom input[type='text']").val(), 10) > parseInt($(this).find(".result-top input[type='text']").val(), 10)) {
          //may change this to inserting a div with the error message
          alert("Result upper end must be above lower end.");

          $("html, body").animate({ scrollTop: $(this).offset().top - 30 }, 250);

          $(this).focus();

          event.preventDefault();

          return false;
        }
    });

    $(".assessment > fieldset > .result").each(function() {

    });
  });
});

function addFields(link, association, content) {
  var newID = new Date().getTime();
  var regExp = new RegExp("new_" + association, "g");

  $(link).parent().append(content.replace(regExp, newID));

  var newLink = $(link).parent().children().last();

  $(link).before(newLink);

  updateDisplayOrders();
}
