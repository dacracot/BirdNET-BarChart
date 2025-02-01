$(function(){
// 	set tabs using jQuery UI
	$("#tabs").tabs();
	$("#tab-chart").tabs();
	$("#tab-chart-day").tabs();
	$("#tab-chart-week").tabs();
	$("#tab-chart-month").tabs();
	$("#tab-chart-year").tabs();
	$("#tab-table").tabs();
	$("#tab-table-day").tabs();
	$("#tab-table-week").tabs();
	$("#tab-table-month").tabs();
	$("#tab-table-year").tabs();
// 	set colors for SVG barcharts
	var myColors = [
		"Aquamarine", "Blue", "Brown", "Chocolate", "Coral", "CornflowerBlue", "Crimson",
		"DarkCyan", "DarkGoldenRod", "DeepPink", "DeepSkyBlue", "ForestGreen", "Fuchsia",
		"Gold", "Green", "GreenYellow", "Maroon", "Orange", "Plum", "Purple", "Red",
		"Tan", "Turquoise", "Violet", "Yellow"
		];
	var bars = document. getElementsByTagName("rect");
	for (var i = bars.length - 1; i >= 0; i--) {
		bars[i].style = "fill:"+myColors[Math.floor(Math.random() * myColors.length)];
		}
	});
