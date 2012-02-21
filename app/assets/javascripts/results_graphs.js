$(function() {
	var backgroundColors = [ "#be2025", "#ed2024", "#ef4b23", "#faa41a", "#fdd803", "#f3ec1a", "#b3d334", "#61bc46", "#549140", "#166432" ];

	$(".results-page").each(function() {
		var assessmentTitle = $(this).find(".assessment-title").text();

		var assessmentResultCoverPageGraph = $(this).find(".results-page-graph")[0];
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

		var assessmentScore = parseInt($(this).parent().find(".assessment-score").text());
	    var assessmentMinScore = parseInt($(this).parent().find(".assessment-min-score").text());
	    var assessmentMaxScore = parseInt($(this).parent().find(".assessment-max-score").text());
		var assessmentPercent = Math.round((Math.abs(assessmentScore - assessmentMinScore) / Math.abs(assessmentMaxScore - assessmentMinScore)) * 100);

		context.shadowOffsetX = 0;
		context.shadowOffsetY = 0;
		context.shadowBlur = 5;
		context.shadowColor = "rgba(64, 64, 65, 0.5)";

		i = 0;

		context.fillStyle = "#404041";
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
			context.fillStyle = "#404041";
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
		});

		var coverPageTop = new Image();

		coverPageTop.onload = function() {
			context.drawImage(coverPageTop, 0, 0);

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

			coverPageMagnifyingGlass.onload = function() {
				context.drawImage(coverPageMagnifyingGlass, 655, 45);

				var coverPageBottom = new Image();

				coverPageBottom.onload = function() {
					context.drawImage(coverPageBottom, 0, 300.5 + (i * 50));

					var coverPageCEOFocusLogo = new Image();

					coverPageCEOFocusLogo.onload = function() {
						context.drawImage(coverPageCEOFocusLogo, width - 250, 363.5 + (i * 50));

						context.shadowOffsetX = 0;
						context.shadowOffsetY = 0;
						context.shadowBlur = 5;
						context.shadowColor = "rgba(64, 64, 65, 0.5)";

						context.fillStyle = "#404041";
						context.font = "bold 30px sans-serif";

						context.fillText(assessmentPercent.toString() + "%", 725, 135);

						context.font = "bold 50px sans-serif";

						context.fillText(assessmentTitle, 60, 80);

						context.font = "bold 38px sans-serif";

						context.fillText("Results", 60, 120);
					}

					coverPageCEOFocusLogo.src = "/assets/ceo-focus-logo.png";
				}

				coverPageBottom.src = "/assets/cover-page-bottom.png";
			}

			coverPageMagnifyingGlass.src = "/assets/cover-page-magnifying-glass.png";
		}

		coverPageTop.src = "/assets/cover-page-top-short.png";
	});
});
