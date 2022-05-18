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
* Java servlet hosting a SQLite database
  * URL to execute SQL
* Web page
  * Javascript to render a SVG barChart
  * Parameters
    * Timeframe
    * Time interval
    * Confidence
    * Bird filter

### Dependencies:

* Java 11+
* Ant with Ivy
* Tomcat 9
* SQLite