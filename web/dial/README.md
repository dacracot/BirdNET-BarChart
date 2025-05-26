# dial Directory

This is where files for the dial graph are written and read.

---

### Files:

* dial.css
	* Cascading style sheet global formatting.
	* Partially based off of this [multi-select](https://codepen.io/sitelint/pen/poGeJpv).
* dial.html
	* The web user interface as rendered by the other files listed here.
* dial.js
	* Javascript for UI temporal changes and mouseover.
* dial.sql
	* Structured query language for pulling celestial, weather, and bird data into XML.
* dial.xml
	* XML data as extracted from the database.
* dial.xsl
	* XML stylesheet language for construction of the dial.

---

### Compromise:

* Handling touch screens:
	* Mouse events are handled differently on mobile, aka touch screen, devices.
	* The clickability of dial's bird data works differently when not using a mouse.