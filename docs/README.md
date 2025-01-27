# Explanation of software flow, philosophy, technique, etc.

This software was inspired by the analyzer referenced below so that I could visualize the birds visiting my backyard.
I am a retired software engineer and I have had an interest in Raspberry Pi hardware.  So, I found the analyzer, got
it working, and wrote a few bash scripts to make the recordings, analyze those recordings, insert the results into a
relational database, and then display the results visually via a browser.  I placed it outside in a weather proof box
and now know what birds are sharing their voices with me.

---

### Development and Testing Platform:

* ___Hardware___:
	1. [Raspberry Pi 4B](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/specifications/)
	1. [Mini USB Microphone](https://www.amazon.com/gp/product/B08M37224H/ref=ppx_yo_dt_b_search_asin_title?ie=UTF8&psc=1)
	1. [Micro SD Card 128GB](https://www.amazon.com/gp/product/B07FCMKK5X/ref=ppx_yo_dt_b_search_asin_title?ie=UTF8&th=1)
* ___Software___:
	1. [Raspberry Pi OS Lite (64-bit)](https://www.raspberrypi.com/software/)
		* A port of [Debian](https://www.debian.org) Bookworm with no desktop environment.
	1. [Apache](https://www.apache.org) to serve web content.
	1. [Python 3](https://www.python.org) to support the analyzer.
	1. [SQLite 3](https://www.sqlite.org) to support the barcharter.

---

### Quick Start:

* ___Install the analyzer___ or better yet, follow [their](https://github.com/kahst/BirdNET-Analyzer) documentation:
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
* ___Install the transformer___:
	1. Expand the SaxonC-HE 12.5 release file obtained from [Saxonica](https://www.saxonica.com/download/c.xml).
		* `unzip libsaxon-HEC-linux-aarch64-v12.5.0.zip `
	1. Enter the result's command directory.
		* `cd libsaxon-HEC-linux-aarch64-v12.5.0/command`
	1. Run the script to build your libraries.
		* `./build64-linux.sh`
	1. Install the transformer for general usage.
		* `cd /usr/lib`
		* `sudo mkdir -p Saxonica/SaxonC-HE-12.5.0`
		* `sudo cp ~/SaxonC-HE/libsaxon-HEC-linux-aarch64-v12.5.0/libs/nix/libsaxon-hec-12.5.0.so Saxonica/SaxonC-HE-12.5.0`
		* `sudo ln -s Saxonica/SaxonC-HE-12.5.0/libsaxon-hec-12.5.0.so libsaxon-hec-12.5.0.so`
		* `cd /usr/bin`
		* `sudo mkdir -p Saxonica/SaxonC-HE-12.5.0`
		* `sudo cp ~/SaxonC-HE/libsaxon-HEC-linux-aarch64-v12.5.0/command/transform Saxonica/SaxonC-HE-12.5.0`
		* `sudo ln -s Saxonica/SaxonC-HE-12.5.0/transform XSLTransform`
	1. _Alternatively, set the library path to include the newly built library with an environment variable_.
		* `export LD_LIBRARY_PATH=/home/dacracot/SaxonC-HE/libsaxon-HEC-linux-aarch64-v12.5.0/libs/nix`
		* `ln -s /home/dacracot/SaxonC-HE/libsaxon-HEC-linux-aarch64-v12.5.0/command/transform XSLTransform`
	1. Run transformer test.
		* `XSLTransform -s:some.xml -xsl:some.xsl`
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
		* `http://birding.local/chart/chart.xml`

---

### Files:

* `CONFIGURATION`
  * Example configuration file to set the longitude, latitude, home directory of the analyzer, home directory of the barcharter, and home directory of the web server.
  * This file must be copied the the user's home directory and renamed `.BirdNET-Barchart`.
* `weekly.sh`
  * Updates the species list using the analyzer.
  * Updates the species list removing black listed species.
  * Clean up via deletion and compression of old logs and work files.
* `extract.sh`
	* Query the database to create an XML file for the browser user interface.
	* Uses `extract.sql` to compose the output to chart.xml.
	* Copies the altered chart folder to the web server's published directory.
* `morning.sh`
	* Create today's directory structure for the storage of sound files.
	* Begin recording one minute duration files.
* `evening.sh`
	* Stop the recordings.
	* Run the analyzer against each sound file.
	* Manipulate the analyzer's CSV results to be loaded into the database, primarily changing the filename into a timestamp.
	* Load the database.
	* Delete and compress the work files that day.

---

### Tool References:

* [Apache](https://projects.apache.org/project.html?httpd-http_server)
* [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))
* [BirdNET-Analyzer](https://github.com/kahst/BirdNET-Analyzer)
* [Chart.js](https://www.chartjs.org)
* [SQLite](https://sqlite.org/)
* [XSLT](https://https://en.wikipedia.org/wiki/XSLT)

---

### Useful commands:

* Locating a USB soundcard/microphone:
	* `lsusb -t`
	* `arecord -l`
* If only root can see the USB soundcard/microphone:
	* `sudo arecord -l`
	* `sudo usermod -a -G audio dacracot`
* Setting permissions for an Apache installation:
	* `groupadd webpub`
	* `usermod -a -G webpub dacracot`
	* `groups dacracot`
	* `chown -R root:webpub /var/www`
	* `find /var/www -type d -exec chmod 2775 {} +`
	* `find /var/www -type f -exec chmod 0664 {} +`
