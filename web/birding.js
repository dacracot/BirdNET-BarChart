$(function(){
	// 	------------------------------
	// 	set tabs using jQuery UI
	// 	------------------------------
	$("#tabs").tabs();
	$("#tab-chart").tabs();
	$("#tab-chart-solar").tabs();
	$("#tab-chart-lunar").tabs();
	$("#tab-chart-seasonal").tabs();
	$("#tab-table").tabs();
	$("#tab-table-solar").tabs();
	$("#tab-table-lunar").tabs();
	$("#tab-table-seasonal").tabs();
	$("#tab-dial").tabs();
	$("#tab-dial-solar").tabs();
	$("#tab-dial-lunar").tabs();
	$("#tab-dial-seasonal").tabs();
	// 	------------------------------
	// table sorting
	// 	------------------------------
	function sortTable(table, col, reverse) {
		// use `<tbody>` to ignore `<thead>` and `<tfoot>` rows
		var tb = table.tBodies[0],
			// collect the rows into an array
			tr = Array.prototype.slice.call(tb.rows, 0);
		reverse = -((+reverse) || -1);
		tr = tr.sort(function (a, b) {
			testStringOrNumber = Number(a.cells[col].textContent.trim());
			if (Number.isNaN(testStringOrNumber)) {
				return reverse * (a.cells[col].textContent.trim().localeCompare(b.cells[col].textContent.trim()));
				}
			else {
				return reverse * (Number(a.cells[col].textContent.trim()) - Number(b.cells[col].textContent.trim()));
				}
			});
		// put the sorted rows back
		for(var i = 0; i < tr.length; ++i) tb.appendChild(tr[i]);
		}
	// 	------------------------------
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
	// 	------------------------------
	function makeAllSortable(parent) {
		parent = parent || document.body;
		var t = parent.getElementsByTagName('table'), i = t.length;
		while (--i >= 0) makeSortable(t[i]);
		}
	// 	------------------------------
	makeAllSortable();
	// 	------------------------------
	});
// ------------------------------------------------------------------------------------------------
const isMobile = (navigator.maxTouchPoints > 0);
// ------------------------------------------------------------------------------------------------
function rowHide() {
	document.getElementById("row_sun_moon").style.display = "none";
	document.getElementById("row_00").style.display = "none";
	document.getElementById("row_03").style.display = "none";
	document.getElementById("row_06").style.display = "none";
	document.getElementById("row_09").style.display = "none";
	document.getElementById("row_12").style.display = "none";
	document.getElementById("row_15").style.display = "none";
	document.getElementById("row_18").style.display = "none";
	document.getElementById("row_21").style.display = "none";
	}
// ------------------------------------------------------------------------------------------------
function rowShow(dial) {
	rowHide();
	if (dial >= 10) {
		visibleId = "row_"+dial;
		}
	else {
		visibleId = "row_0"+dial;
		}
	document.getElementById(visibleId).style.display = "block";
	}
// ------------------------------------------------------------------------------------------------
function rowInit() {
	rowHide();
	document.getElementById("row_sun_moon").style.display = "block";
	}
// ------------------------------------------------------------------------------------------------
var date = new Date();
var hour = date.getHours();
document.getElementById("dialText_00").setAttribute("class","textNormal");
document.getElementById("dialText_01").setAttribute("class","textNormal");
document.getElementById("dialText_02").setAttribute("class","textNormal");
document.getElementById("dialText_03").setAttribute("class","textNormal");
document.getElementById("dialText_04").setAttribute("class","textNormal");
document.getElementById("dialText_05").setAttribute("class","textNormal");
document.getElementById("dialText_06").setAttribute("class","textNormal");
document.getElementById("dialText_07").setAttribute("class","textNormal");
document.getElementById("dialText_08").setAttribute("class","textNormal");
document.getElementById("dialText_09").setAttribute("class","textNormal");
document.getElementById("dialText_10").setAttribute("class","textNormal");
document.getElementById("dialText_11").setAttribute("class","textNormal");
document.getElementById("dialText_12").setAttribute("class","textNormal");
document.getElementById("dialText_13").setAttribute("class","textNormal");
document.getElementById("dialText_14").setAttribute("class","textNormal");
document.getElementById("dialText_15").setAttribute("class","textNormal");
document.getElementById("dialText_16").setAttribute("class","textNormal");
document.getElementById("dialText_17").setAttribute("class","textNormal");
document.getElementById("dialText_18").setAttribute("class","textNormal");
document.getElementById("dialText_19").setAttribute("class","textNormal");
document.getElementById("dialText_20").setAttribute("class","textNormal");
document.getElementById("dialText_21").setAttribute("class","textNormal");
document.getElementById("dialText_22").setAttribute("class","textNormal");
document.getElementById("dialText_23").setAttribute("class","textNormal");
// --------
document.getElementById("dialRect_00").setAttribute("class","rectNormal");
document.getElementById("dialRect_01").setAttribute("class","rectNormal");
document.getElementById("dialRect_02").setAttribute("class","rectNormal");
document.getElementById("dialRect_03").setAttribute("class","rectNormal");
document.getElementById("dialRect_04").setAttribute("class","rectNormal");
document.getElementById("dialRect_05").setAttribute("class","rectNormal");
document.getElementById("dialRect_06").setAttribute("class","rectNormal");
document.getElementById("dialRect_07").setAttribute("class","rectNormal");
document.getElementById("dialRect_08").setAttribute("class","rectNormal");
document.getElementById("dialRect_09").setAttribute("class","rectNormal");
document.getElementById("dialRect_10").setAttribute("class","rectNormal");
document.getElementById("dialRect_11").setAttribute("class","rectNormal");
document.getElementById("dialRect_12").setAttribute("class","rectNormal");
document.getElementById("dialRect_13").setAttribute("class","rectNormal");
document.getElementById("dialRect_14").setAttribute("class","rectNormal");
document.getElementById("dialRect_15").setAttribute("class","rectNormal");
document.getElementById("dialRect_16").setAttribute("class","rectNormal");
document.getElementById("dialRect_17").setAttribute("class","rectNormal");
document.getElementById("dialRect_18").setAttribute("class","rectNormal");
document.getElementById("dialRect_19").setAttribute("class","rectNormal");
document.getElementById("dialRect_20").setAttribute("class","rectNormal");
document.getElementById("dialRect_21").setAttribute("class","rectNormal");
document.getElementById("dialRect_22").setAttribute("class","rectNormal");
document.getElementById("dialRect_23").setAttribute("class","rectNormal");
// --------
document.getElementById("dialText_"+String(hour).padStart(2, '0')).setAttribute("class","textHighlight");
document.getElementById("dialRect_"+String(hour).padStart(2, '0')).setAttribute("class","rectHighlight");
// ------------------------------------------------------------------------------------------------
function checkAll(onOff) {
	document.querySelectorAll('input[type=checkbox]').forEach(c => c.checked = onOff);
	if (onOff) {
		document.querySelectorAll('line[id]:not([id="pie"])').forEach(b => b.setAttribute("visibility", "visible"));
		}
	else {
		document.querySelectorAll('line[id]:not([id="pie"])').forEach(b => b.setAttribute("visibility", "hidden"));
		}
	}
checkAll(true);
// ------------------------------------------------------------------------------------------------
function toggleBird(bird) {
	document.querySelectorAll('line[id="'+bird+'"]').forEach(b => {
		let x = b.getAttribute("visibility");
		if (x === "hidden") {
			b.setAttribute("visibility", "visible"); 
			}
		else {
			b.setAttribute("visibility", "hidden"); 
			}
		});
	}
// ------------------------------------------------------------------------------------------------
var popup = null;
// -------------
document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("dial").addEventListener("mousemove", function(event) {
        doMove(event);
        });
    popup = document.getElementById("popup");
    popup.style.visibility = "hidden";
    });
// -------------
function doEnter(bird,when,confidence,quantity) {
	let popHead = null;
	if (isMobile) {
		popHead = '<a href="https://www.allaboutbirds.org/guide/'+bird.replace(" ","_")+'" target="_blank">'+bird+'</a>';
		}
	else {
		popHead = bird;
		}
    popup.innerHTML = '<span style="font-family: Arial, Helvetica, sans-serif; font-size: 10px;">'+
						'<table style="border: 1px solid black; border-collapse: collapse; padding: 5px;"><thead><tr><th colspan="2" style="text-align: center; border: 1px solid black; border-collapse: collapse;">'+
						popHead+
						'</th></tr></thead><tbody><tr><th>quantity:</th><td>'+
						quantity+
						'</td></tr><tr><th>confidence:</th><td>'+
						confidence+
						'</td></tr><tr><th>when:</th><td>'+
						when+
						'</td></tr></tbody></table></span>';
    popup.style.visibility = "visible";
    };
function doLeave(){
    popup.style.visibility = "hidden";
    };
function doMove(what){
    popup.style.left = (what.pageX + 5) + "px";
    popup.style.top = (what.pageY + 5) + "px";
    };
function lookUp(bird){
	if (!isMobile) window.open('https://www.allaboutbirds.org/guide/'+bird.replace(" ","_"), '_blank');
    };
// ------------------------------------------------------------------------------------------------
function daysLastYear() {
	const YEAR = new Date().getFullYear();
	const LASTYEAR = YEAR - 1;
	let isleap = false;
	if (LASTYEAR % 4 !== 0) {
		// not a leap year
		}
	else if (LASTYEAR % 400 === 0) {
		isleap = true;
		}
	else if (LASTYEAR % 100 === 0) {
		// not a leap year
		}
	else {
		isleap = true;
		}
	return isleap ? 366 : 365;
	}
// ------------------------------------------------------------------------------------------------
let lunarLoop=false;
// ------------------------------------------------------------------------------------------------
function lunarDialing() {
	const DAYOFYEAR = Math.floor((new Date() - new Date(YEAR, 0, 0)) / 1000 / 60 / 60 / 24);
console.log("DAYOFYEAR = "+DAYOFYEAR);
	const DAYSLASTYEAR = daysLastYear();
console.log("DAYSLASTYEAR = "+DAYSLASTYEAR);
	const sleep = (ms) => new Promise(resolve => setTimeout(resolve, ms));
	const image = document.getElementById('lunar');
	for (let i = 30; i >= 1; i--) {
		let DAY = DAYOFYEAR - i;
		if (DAY <= 0) {
			DAY += DAYSLASTYEAR;
			}
console.log("DAY = "+DAY);
		for (let HOUR = 0; i <= 23; i++) {
 			image.src='grfx/svg/dial/' + DAY + '/' + HOUR + '.svg';
console.log("image.src= grfx/svg/dial/" + DAY + "/" + HOUR + ".svg");
			sleep(40);
			}
		if (!lunarLoop) break;
		}
	}
// ------------------------------------------------------------------------------------------------
function lunarSpin() {
	lunarLoop=true;
	}
// ------------------------------------------------------------------------------------------------
function lunarIdle() {
	lunarLoop=false;
	lunarDialing();
	}
// ------------------------------------------------------------------------------------------------
function seasonalSpin() {
	console.log("not yet");
	}
// ------------------------------------------------------------------------------------------------
function seasonalIdle() {
	console.log("not yet");
	}
// ------------------------------------------------------------------------------------------------
console.log("refreshed at "+date);
