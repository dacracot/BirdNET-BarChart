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
}
// ------------------------------------------------------------------------------------------------
console.log("refreshed at "+date);
