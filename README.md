# BirdNET-BarChart

Display BirdNET-Analyzer data as a bar chart in a browser.

---

### Components:

* BirdNET-Analyzer
  * Analyze WAV file for bird song
* bash scripting via crontab
  * Run the sound recorder
  * Run the analysis
  * Load the database
  * Extract the web page
* Web page
  * Chart.js
  * Browser rendered XSLT

### Dependencies:

* SQLite 3
* BirdNet-Analyzer (tested with v1.5.1)
