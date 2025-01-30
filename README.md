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

* [Bash](https://linuxconfig.org/bash-scripting-tutorial-for-beginners)
* [BirdNET-Analyzer](https://github.com/kahst/BirdNET-Analyzer)
* [SQLite](https://sqlite.org/)
* [XSLT](https://www.w3schools.com/xml/xsl_intro.asp)
* [SVG](https://www.w3schools.com/graphics/svg_intro.asp)
* [Apache](https://projects.apache.org/project.html?httpd-http_server)
