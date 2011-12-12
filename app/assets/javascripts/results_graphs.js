window.requestAnimFrame = (function(callback) {
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
});