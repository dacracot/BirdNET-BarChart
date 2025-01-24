# Explanation of software flow, philosophy, technique, etc.

This is a description of what and why components are how they are.

---

### Quick Start:

* ___Install the analyzer___:
	1. Expand the release file obtained from the BirdNET-Analyzer GitHub.
		* `tar xzvf v1.5.1.tar.gz`
	1. Enter the resultant directory.
		* `cd BirdNET-Analyzer-1.5.1`
	1. Create the Python virtual environment.
		* `python3 -m venv venv-birdnet`
	1. Activate the Python virtual environment.
		* `source venv-birdnet/bin/activate`
	1. Add the analyzer dependencies.
		* `python -m pip install -U pip`
		* `pip3 install tflite-runtime`
		* `pip3 install librosa resampy`
		* `pip3 install keras_tuner`
		* `pip3 install tensorflow==2.15.0`
	1. Run the analyzer test.
		* `python3 -m birdnet_analyzer.analyze`
* ___Install this software___:
	1. Expand the release file obtained from the BirdNET-Barchart GitHub.
		* `tar xzvf v0.9.tar.gz`
	1. Enter the resultant directory.
		* `cd BirdNET-Barchart-0.9`
	1. Edit the configuration file with your lat/lon, the analyzer's home directory, and this software's home directory.  Copy your saved file to your user's home directory as `.BirdNET-Barchart`.
		* `vi CONFIGURATION`
		* `cp CONFIGURATION ~/.BirdNET-Barchart`
	1. Edit your crontab and insert the scripts for weekly, morning, evening, and extract actions.
		* `30 2 * * 7 /home/dacracot/v0.9/BirdNET-Barchart-0.9/weekly.sh`
		* `0 3 * * * /home/dacracot/v0.9/BirdNET-Barchart-0.9/extract.sh`
		* `0 4 * * * /home/dacracot/v0.9/BirdNET-Barchart-0.9/morning.sh`
		* `0 22 * * * /home/dacracot/v0.9/BirdNET-Barchart-0.9/evening.sh`
	1. Access the browser user interface...

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

* Useful commands for locating the USB microphone.
	* `lsusb -t`
	* `arecord -l`