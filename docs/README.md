# Explanation of software flow, philosophy, technique, etc.

This is a description of what and why components are how they are.

---

### Files:

* `CONFIGURATION`
  * Example configuration file to set the longitude, latitude, home directory of the analyzer, and home directory of the barcharter.
  * This file must be copied the the user's home directory and renamed `.BirdNET-Barchart`.
* `weekly.sh`
  * Updates the species list using the analyzer.
  * Updates the species list removing black listed species.
  * Clean up via deletion and compression of old logs and work files.
* `extract.sh`
	* Query the database to create an XML file for the browser user interface.
	* Uses `extract.sql` to compose the output.
* `morning.sh`
	* Create today's directory structure for the storage of sound files.
	* Begin recording one minute duration files.
* `evening.sh`
	* Stop the recordings.
	* Run the analyzer against each sound file.
	* Manipulate the analyzer's CSV results to be loaded into the database, primarily changing the filename into a timestamp.
	* Load the database.
	* Delete and compress the work files that day.

### Tool References:

* [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))
* [BirdNET-Analyzer](https://github.com/kahst/BirdNET-Analyzer)
* [Chart.js](https://www.chartjs.org)
* [SQLite](https://sqlite.org/)

### Commands for the usage of the tool:

* `crontab` is used to execute each of the scripts.
	* `30 2 * * 7 /home/chirp/weekly.sh`
	* `0 3 * * * /home/chirp/extract.sh`
	* `0 4 * * * /home/chirp/morning.sh`
	* `0 22 * * * /home/chirp/evening.sh`
* Useful commands for locating the USB microphone.
	* `lsusb -t`
	* `arecord -l`