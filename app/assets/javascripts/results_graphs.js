$(function() {
	var backgroundColors = [ "#be2025", "#ed2024", "#ef4b23", "#faa41a", "#fdd803", "#f3ec1a", "#b3d334", "#61bc46", "#549140", "#166432" ];

	$(".cover-page").each(function() {
		var assessmentResultCoverPageGraph = $(this).find(".cover-page-graph")[0];
		var context = assessmentResultCoverPageGraph.getContext("2d");

		var height = assessmentResultCoverPageGraph.offsetHeight;
		var width = assessmentResultCoverPageGraph.offsetWidth;

		var i;

		for (i = 0; i < 10; i++) {
			context.beginPath();
			context.rect((i * ((width - 100) / 10)) + 50, 50, (width - 100) / 10, height - 100);
			context.fillStyle = backgroundColors[i];
			context.fill();
			context.closePath();
		}

		var coverPageTop = new Image();

		coverPageTop.src = "/assets/cover-page-top-short.png";

		context.drawImage(coverPageTop, 0, 0);

		var assessmentScore = parseInt($(this).parent().find(".assessment-score").text());
	    var assessmentMinScore = parseInt($(this).parent().find(".assessment-min-score").text());
	    var assessmentMaxScore = parseInt($(this).parent().find(".assessment-max-score").text());
		var assessmentPercent = Math.round((Math.abs(assessmentScore - assessmentMinScore) / Math.abs(assessmentMaxScore - assessmentMinScore)) * 100);

		if (assessmentPercent === 0) {
			context.fillStyle = backgroundColors[0];
		} else {
			context.fillStyle = backgroundColors[Math.ceil((assessmentPercent / 10) - 1)];
		}

		context.beginPath();
		context.arc(765, 125, 65, 0, Math.PI * 2, true);
		context.closePath();
		context.fill();

		var coverPageMagnifyingGlass = new Image();

		coverPageMagnifyingGlass.src = "/assets/cover-page-magnifying-glass.png";

		context.drawImage(coverPageMagnifyingGlass, 655, 45);

		context.shadowOffsetX = 0;
		context.shadowOffsetY = 0;
		context.shadowBlur = 5;
		context.shadowColor = "rgba(64, 64, 65, 0.5)";

		context.fillStyle = "#404041";
		context.font = "bold 30px sans-serif";

		context.fillText(assessmentPercent.toString() + "%", 725, 135);

		context.font = "bold 50px sans-serif";

		context.fillText($(this).find(".assessment-title").text(), 60, 80);

		context.font = "bold 38px sans-serif";

		context.fillText("Results", 60, 120);

		i = 0;

		context.strokeStyle = "#404041";
		context.lineWidth = 3;

		$(this).find(".section").each(function() {
			context.shadowBlur = 0;
			context.shadowColor = "rgba(0, 0, 0, 0.0)";

			context.beginPath();
			context.moveTo(74.5, 350.5 + (i * 50));
			context.lineTo(width - 74.5, 350.5 + (i * 50));
			context.stroke();
			context.closePath();

			var sectionScore = parseInt($(this).find(".section-score").text());
		    var sectionMinScore = parseInt($(this).find(".section-min-score").text());
		    var sectionMaxScore = parseInt($(this).find(".section-max-score").text());
			var sectionPercent = Math.round((Math.abs(sectionScore - sectionMinScore) / Math.abs(sectionMaxScore - sectionMinScore)) * 100);

			context.beginPath();
			context.strokeStyle = "#404041";
			context.arc(74.5 + Math.round((sectionPercent / 100) * 800), 350.5 + (i * 50), 15, 0, Math.PI * 2, true);
			context.closePath();
			context.fill();

			context.font = "15px sans-serif";
			context.shadowBlur = 3;
			context.shadowColor = "rgba(255, 255, 255, 0.8)";

			var sectionNameX = (74.5 + Math.round((sectionPercent / 100) * 800)) - (context.measureText($(this).find(".section-title").text()).width / 2);
			if (sectionNameX < 84.5) {
				sectionNameX = 84.5;
			}
			if (sectionNameX > (width - 74.5) - ((context.measureText($(this).find(".section-title").text()).width / 2) + 10)) {
				sectioNameX = (width - 74.5) - ((context.measureText($(this).find(".section-title").text()).width / 2) + 10);
			}

			context.fillText($(this).find(".section-title").text(), sectionNameX, 378.5 + (i * 50));

			i++;
		})

		var coverPageBottom = new Image();

		coverPageBottom.src = "/assets/cover-page-bottom.png";

		context.drawImage(coverPageBottom, 0, 300.5 + (i * 50));

		var coverPageCEOFocusLogo = new Image();

		coverPageCEOFocusLogo.src = "/assets/ceo-focus-logo.png";

		context.drawImage(coverPageCEOFocusLogo, width - 250, 363.5 + (i * 50))
	});
});

/*window.requestAnimFrame = (function(callback) {
	return window.requestAnimationFrame ||
	window.webkitRequestAnimationFrame ||
	window.mozRequestAnimationFrame ||
	window.oRequestAnimationFrame ||
	window.msRequestAnimationFrame ||
	function(callback){
		window.setTimeout(callback, 1000 / 60);
	};
})();

function animateLine(lastTime, canvas, position, endPercentage) {
	var context = canvas.getContext("2d");

	var height = canvas.offsetHeight;
	var width = canvas.offsetWidth;

	var date = new Date();
	var time = date.getTime();
	var timeDiff = time - lastTime;
	var velocity = 60.0;
	var distanceEachFrame = velocity * timeDiff / 1000;
	var newPosition = position + distanceEachFrame;

	lastTime = time;

	canvas.width = canvas.width;

	var linearGradient = context.createLinearGradient(0, 0, width, height);
  linearGradient.addColorStop(0, "#ff0000");
  linearGradient.addColorStop(1, "#00ff00");
  context.fillStyle = linearGradient;
  context.fillRect(0, 0, width, height);

  context.lineWidth = 1;

  context.beginPath();

	context.moveTo(0.5, 0.5);
	context.lineTo(0.5, 0.5 + height);
	context.stroke();

	context.moveTo(0.5 + width, 0.5);
	context.lineTo(0.5 + width, 0.5 + height);
	context.stroke();

	context.moveTo(0.5, 0.5 + (height / 2));
	context.lineTo(0.5 + width, 0.5 + (height / 2));
	context.stroke();

	for (var i = 1; i < 10; i++) {
		context.moveTo(0.5 + i * (width / 10), 0.5 + (height / 2) - (height / 4));
		context.lineTo(0.5 + i * (width / 10), 0.5 + (height / 2) + (height / 4));
		context.stroke();
	}

	context.lineWidth = 5;
	context.beginPath();

	context.moveTo(0.5 + newPosition, 0.5 + (height / 2) - (height / 3));
	context.lineTo(0.5 + newPosition, 0.5 + (height / 2) + (height / 3));
	context.stroke();

  var finalPosition = (endPercentage * width) - 5;

	if (newPosition < finalPosition) {
		requestAnimFrame(function() {
			animateLine(lastTime, canvas, newPosition, endPercentage);
		});
	}
}

$(function() {
  $(".assessment-result").each(function() {
    var assessmentScore = parseInt($(this).find(".assessment-score").text());
    var assessmentMaxScore = parseInt($(this).find(".assessment-max-score").text());
    var assessmentPercentage = (assessmentScore / assessmentMaxScore);

    var assessmentCoverPageOverallResultCanvas = $(this).find(".assessment-cover-page-overall-graph-canvas")[0];

    var date = new Date();
  	var time = date.getTime();

  	animateLine(time, assessmentCoverPageOverallResultCanvas, 0, assessmentPercentage);

    $(this).find(".cover-page-section-graph").each(function() {
      var assessmentCoverPageSectionResultCanvas = $(this).find(".assessment-cover-page-section-graph-canvas")[0];

      var sectionScore = parseInt($(this).find(".section-score").text());
      var sectionMaxScore = parseInt($(this).find(".section-max-score").text());
      var sectionPercentage = (sectionScore / sectionMaxScore);

  	  date = new Date();
  	  time = date.getTime();

  	  animateLine(time, assessmentCoverPageSectionResultCanvas, 0, sectionPercentage);
    });

    var assessmentResultCanvas = $(this).find(".assessment-graph-canvas")[0];

  	var date = new Date();
  	var time = date.getTime();

  	animateLine(time, assessmentResultCanvas, 0, assessmentPercentage);

  	$(this).find(".section-result").each(function() {
  	  var sectionResultCanvas = $(this).find(".section-graph-canvas")[0];

      var sectionScore = parseInt($(this).find(".section-score").text());
      var sectionMaxScore = parseInt($(this).find(".section-max-score").text());
      var sectionPercentage = (sectionScore / sectionMaxScore);

  	  date = new Date();
  	  time = date.getTime();

  	  animateLine(time, sectionResultCanvas, 0, sectionPercentage);
  	});
  });
});*/