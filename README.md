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
	* Extract the web resources to display the results.
* Render a browser user interface.
	* Transform XML using XSLT to produce a bar chart with controls.
	* Render the bar chart with a Javascript library.

### Dependencies:

* [Bash](https://linuxconfig.org/bash-scripting-tutorial-for-beginners)
* [BirdNET-Analyzer](https://github.com/kahst/BirdNET-Analyzer)
* [Chart.js](https://www.chartjs.org)
* [SQLite](https://sqlite.org/)
* [XSLT](https://www.w3schools.com/xml/xsl_intro.asp)
