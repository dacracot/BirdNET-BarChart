$(function(){
	// 	------------------------------
	// 	set tabs using jQuery UI
	// 	------------------------------
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
	// 	------------------------------
	// 	set colors for SVG barcharts
	// 	------------------------------
	const hiSeed = 1111;
	const midSeed = 2222;
	const lowSeed = 3333;
	const maxRGBvalue = 255;
	// pseudo random number generator
	let random = (function () {
		let a = 1, b = 1, hi = 100, off = 0;
		return {
			nextRandom: function () {
				a = (a * 67307) & 0xffff;
				b = (b * 67427) & 0xffff;
				return Math.round((((a ^ (b << 15)) / 2147483647) * hi) + off);
				},
			// reset with a seed, set max, and offset
			reset(seed,max,offset) {
				a = b = seed | 0;
				hi = max;
				off = offset;
				}
			};
		})();
	// start sequence with hiSeed
	random.reset(hiSeed,maxRGBvalue,0);
	// select the tab by id
	let tab = document.querySelector("#tab-chart-day-hi");
	// select all rectangles that are children of the tab
	let bars = tab.querySelectorAll("rect");
	bars.forEach(b => {b.style = "fill:rgb("+random.nextRandom()+","+random.nextRandom()+","+random.nextRandom()+")";});
	// 	------------------------------
	// start sequence with hiSeed
	random.reset(hiSeed,maxRGBvalue,0);
	// select the tab by id
	tab = document.querySelector("#tab-chart-week-hi");
	// select all rectangles that are children of the tab
	bars = tab.querySelectorAll("rect");
	bars.forEach(b => {b.style = "fill:rgb("+random.nextRandom()+","+random.nextRandom()+","+random.nextRandom()+")";});
	// 	------------------------------
	// start sequence with hiSeed
	random.reset(hiSeed,maxRGBvalue,0);
	// select the tab by id
	tab = document.querySelector("#tab-chart-month-hi");
	// select all rectangles that are children of the tab
	bars = tab.querySelectorAll("rect");
	bars.forEach(b => {b.style = "fill:rgb("+random.nextRandom()+","+random.nextRandom()+","+random.nextRandom()+")";});
	// 	------------------------------
	// start sequence with hiSeed
	random.reset(hiSeed,maxRGBvalue,0);
	// select the tab by id
	tab = document.querySelector("#tab-chart-year-hi");
	// select all rectangles that are children of the tab
	bars = tab.querySelectorAll("rect");
	bars.forEach(b => {b.style = "fill:rgb("+random.nextRandom()+","+random.nextRandom()+","+random.nextRandom()+")";});
	// 	------------------------------
	// 	------------------------------
	// start sequence with midSeed
	random.reset(midSeed,maxRGBvalue,0);
	// select the tab by id
	tab = document.querySelector("#tab-chart-day-mid");
	// select all rectangles that are children of the tab
	bars = tab.querySelectorAll("rect");
	bars.forEach(b => {b.style = "fill:rgb("+random.nextRandom()+","+random.nextRandom()+","+random.nextRandom()+")";});
	// 	------------------------------
	// start sequence with hiSeed
	random.reset(midSeed,maxRGBvalue,0);
	// select the tab by id
	tab = document.querySelector("#tab-chart-week-mid");
	// select all rectangles that are children of the tab
	bars = tab.querySelectorAll("rect");
	bars.forEach(b => {b.style = "fill:rgb("+random.nextRandom()+","+random.nextRandom()+","+random.nextRandom()+")";});
	// 	------------------------------
	// start sequence with hiSeed
	random.reset(midSeed,maxRGBvalue,0);
	// select the tab by id
	tab = document.querySelector("#tab-chart-month-mid");
	// select all rectangles that are children of the tab
	bars = tab.querySelectorAll("rect");
	bars.forEach(b => {b.style = "fill:rgb("+random.nextRandom()+","+random.nextRandom()+","+random.nextRandom()+")";});
	// 	------------------------------
	// start sequence with hiSeed
	random.reset(midSeed,maxRGBvalue,0);
	// select the tab by id
	tab = document.querySelector("#tab-chart-year-mid");
	// select all rectangles that are children of the tab
	bars = tab.querySelectorAll("rect");
	bars.forEach(b => {b.style = "fill:rgb("+random.nextRandom()+","+random.nextRandom()+","+random.nextRandom()+")";});
	// 	------------------------------
	// 	------------------------------
	// start sequence with lowSeed
	random.reset(lowSeed,maxRGBvalue,0);
	// select the tab by id
	tab = document.querySelector("#tab-chart-day-low");
	// select all rectangles that are children of the tab
	bars = tab.querySelectorAll("rect");
	bars.forEach(b => {b.style = "fill:rgb("+random.nextRandom()+","+random.nextRandom()+","+random.nextRandom()+")";});
	// 	------------------------------
	// start sequence with hiSeed
	random.reset(lowSeed,maxRGBvalue,0);
	// select the tab by id
	tab = document.querySelector("#tab-chart-week-low");
	// select all rectangles that are children of the tab
	bars = tab.querySelectorAll("rect");
	bars.forEach(b => {b.style = "fill:rgb("+random.nextRandom()+","+random.nextRandom()+","+random.nextRandom()+")";});
	// 	------------------------------
	// start sequence with hiSeed
	random.reset(lowSeed,maxRGBvalue,0);
	// select the tab by id
	tab = document.querySelector("#tab-chart-month-low");
	// select all rectangles that are children of the tab
	bars = tab.querySelectorAll("rect");
	bars.forEach(b => {b.style = "fill:rgb("+random.nextRandom()+","+random.nextRandom()+","+random.nextRandom()+")";});
	// 	------------------------------
	// start sequence with hiSeed
	random.reset(lowSeed,maxRGBvalue,0);
	// select the tab by id
	tab = document.querySelector("#tab-chart-year-low");
	// select all rectangles that are children of the tab
	bars = tab.querySelectorAll("rect");
	bars.forEach(b => {b.style = "fill:rgb("+random.nextRandom()+","+random.nextRandom()+","+random.nextRandom()+")";});
	// 	------------------------------
	// Code from https://jsfiddle.net/zscQy/
	function sortTable(table, col, reverse) {
		var tb = table.tBodies[0], // use `<tbody>` to ignore `<thead>` and `<tfoot>` rows
			tr = Array.prototype.slice.call(tb.rows, 0), // put rows into array
			i;
		reverse = -((+reverse) || -1);
		tr = tr.sort(function (a, b) {
console.log("===============================");
		testStringOrNumber = Number(a.cells[col].textContent.trim());
console.log("testStringOrNumber = "+testStringOrNumber);
		if (Number.isNaN(testStringOrNumber)) {
console.log("string");
			return reverse * (a.cells[col].textContent.trim().localeCompare(b.cells[col].textContent.trim()));
			}
		else {
console.log("number");
			return reverse * (Number(a.cells[col].textContent.trim()) - Number(b.cells[col].textContent.trim()));
			}
		});
console.log("-------------------------------");
		for(i = 0; i < tr.length; ++i) tb.appendChild(tr[i]); // append each row in order
		}
	function makeSortable(table) {
		var th = table.tHead, i;
		th && (th = th.rows[0]) && (th = th.cells);
		if (th) i = th.length;
		else return; // if no `<thead>` then do nothing
		while (--i >= 0) (function (i) {
			var dir = 1;
			th[i].addEventListener('click', function () {sortTable(table, i, (dir = 1 - dir))});
			}(i));
		}
	function makeAllSortable(parent) {
		parent = parent || document.body;
		var t = parent.getElementsByTagName('table'), i = t.length;
		while (--i >= 0) makeSortable(t[i]);
		}
	makeAllSortable();
	// 	------------------------------
	});
