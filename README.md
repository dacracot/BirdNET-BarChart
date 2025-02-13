# BirdNET-BarChart

Display BirdNET-Analyzer data as a bar chart in a browser.

---

### Components:

* BirdNET-Analyzer
	* Analyze sound files for bird song for determination of species.
* Using bash scripts to drive the daily processing.
	* Run the sound recorder to capture bird song.
	* Run the analysis to identify the bird song.
	* Load the database with the observed species.
	* Extract the database data to XML.
	* Transform XML using XSLT to produce a bar charts and tables.

### Dependencies:

* [Apache](https://projects.apache.org/project.html?httpd-http_server)
* [Bash](https://linuxconfig.org/bash-scripting-tutorial-for-beginners)
* [BirdNET-Analyzer](https://github.com/kahst/BirdNET-Analyzer)
* [inotifywait](https://linux.die.net/man/1/inotifywait)
* [jq - CLI JSON processor](https://jqlang.org/)
* [jQueryUI](https://jqueryui.com)
* [SQLite](https://sqlite.org/)
* [SVG](https://www.w3schools.com/graphics/svg_intro.asp)
* [XSLT](https://www.w3schools.com/xml/xsl_intro.asp)
