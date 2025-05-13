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
