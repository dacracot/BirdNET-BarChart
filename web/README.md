# web Directory

This is where all the web based report generation components are kept.

---

### Files:

* birding.css
	* Cascading style sheet to aid in the display of the user interface.
* birding.html
	* The temporal HTML, web user interface as rendered by the other files listed here.
* birding.js
	* Javascript to control and manipulate the browser user interface.
* birding.sql
	* Extract the applicable data from the database.
* birding.xml
	* Temporal XML data as extracted from the database.
* birding.xsl
	* XML stylesheet transform for browser side rendering of the web user interface.
* chart.xsl
	* XML stylesheet transform for bar charts and tables.
* dial.xsl
	* XML stylesheet transform for solr/lunar/seasonal dial displays.
* favicon.ico
	* "Favorite icon" for use with browser URL bars.
* help.html
	* Show a video (help.mp4) of the user interface.
* tabs.xsl
	* XML stylesheet transform for tab navigation.

---

### Subdirectories:

* grfx
	* The location of the images displayed in the web interface.
	* SVG files are [scalable vector graphics](https://www.w3schools.com/graphics/svg_intro.asp).

---

### Compromise:

* Handling touch screens:
	* Mouse events are handled differently on mobile, aka touch screen, devices.
	* The clickability of dial's bird data works differently when not using a mouse.