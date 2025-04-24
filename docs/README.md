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
	1. [XSLTransform](https://en.wikipedia.org/wiki/XSLT) to support the barcharter.
	1. [SVG](https://en.wikipedia.org/wiki/SVG) to render the charts in the browser.
	1. [sSMTP](https://packages.debian.org/source/unstable/ssmtp) to send alert emails when unrecoverable errors occur.

---

### Quick Start:

* ___Install the OS___:
	1. Using the [Raspberry Pi Imager](https://www.raspberrypi.com/news/raspberry-pi-imager-imaging-utility/) install the Lite (64-bit) version of the Raspberry Pi OS.
	1. Enter your customizations for hostname, initial user, WiFi, locale, and ssh.
	1. Boot your new system and run `sudo apt update`, then `sudo apt upgrade`, and `sudo apt autoremove` to get all the latest base software.
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
		* `mkdir SaxonC-HE`
		* `cd SaxonC-HE`
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
	1. Install sqlite, Apache, sshpass, and sSMTP.
		* `sudo apt install sqlite3`
		* `sudo apt install apache2`
		* `sudo apt install jq`
		* `sudo apt install sshpass`
		* `sudo apt install ssmtp`
	1. Expand the release file obtained from the BirdNET-BarChart GitHub.
		* `tar xzvf BirdNET-BarChart-#.#.#.tar.gz`
	1. Save your previously populated sqlite database if you have one.
		* `mv /home/dacracot/BirdNET-BarChart/birds.db /tmp/birds.db`
	1. Rename and enter the resultant directory.
		* `mv /home/dacracot/BirdNET-BarChart-#.#.# /home/dacracot/BirdNET-BarChart`
		* `cd /home/dacracot/BirdNET-BarChart`
	1. Replace the empty sqlite database with your backup if you have one.
		* `mv /tmp/birds.db /home/dacracot/BirdNET-BarChart`
	1. Edit the crontab.txt to adjust times for scripts prior to running the config script.
		* `15 2 * * 7 /home/dacracot/BirdNET-BarChart/backup/backup.sh`
		* `45 2 1 1 * /home/dacracot/BirdNET-BarChart/yearly.sh`
		* `30 2 * * 7 /home/dacracot/BirdNET-BarChart/weekly.sh`
		* `0 2 * * * /home/dacracot/BirdNET-BarChart/daily.sh`
		* `0 * * * * /home/dacracot/BirdNET-BarChart/hourly.sh`
	1. Run the configuration script and enter your lat/lon, the analyzer's home directory, this software's home directory, the web servers HTML directory, and whatever maximum storage percentage you can tolerate.
		* `config.sh`
	1. Run the weekly script to get the latest species.
		* `/home/dacracot/BirdNET-BarChart/weekly.sh`
	1. Access the browser user interface...
		* `http://birding.local/chart/chart.html`

---

### Files:

* `config.sh`
  * Script to set the longitude, latitude, home directory of the analyzer, home directory of the barcharter, home directory of the web server, maximum percentage storage usage, backup URI, and its password.
  * The results will be written to the user's home directory and named `.BirdNET-BarChart`.
* `weekly.sh`
  * Updates the species list using the analyzer.
  * Updates the species list removing black listed species.
  * Clean up via deletion and compression of old logs and work files.
    * Clean up is done via a progression of:
      1. Compressing all log files older than today.
      1. Deleting all log files older than a week.
      1. Deleting all sound sample (.wav) files older than first 90 days, then 89, then 88, and so on.
    * Until the percent usage is below the maximum configured.
* `hourly.sh`
	* Create today's directory structure for the storage of sound files.
	* Begin recording one minute duration files.
	* Stop the recordings.
	* Run the analyzer against each sound file.
	* Manipulate the analyzer's CSV results to be loaded into the database, primarily changing the filename into a timestamp.
	* Load the database.
	* Delete and compress the work files that hour.
	* Query the database to create an XML file for the browser user interface.
	* Uses `extract.sql` to compose the output to `chart.xml`.
	* Transform the `chart.xml` into `chart.html` using `chart.xsl`.
	* Copies the altered chart folder to the web server's published directory.
* `daily.sh`
	* Query celestial data from the US Navy.
	* Morph the data into SQL and load the database.
* `start.sh`
	* Start the process of recording data.
* `stop.sh`
	* Stop the process of recording data.

---

### Tool References:

* [Apache](https://projects.apache.org/project.html?httpd-http_server)
* [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))
* [BirdNET-Analyzer](https://github.com/kahst/BirdNET-Analyzer)
* [jQueryUI](https://jqueryui.com)
* [jq](https://jqlang.org)
* [SQLite](https://sqlite.org/)
* [sSMTP](https://netcorecloud.com/tutorials/linux-send-mail-from-command-line-using-smtp-server/)
* [SVG](https://www.w3.org/Graphics/SVG/)
* [XSLT](https://www.w3.org/Style/XSL/) implemented using [Saxon](https://www.saxonica.com/welcome/welcome.xml)

---

### Additional Learning References:

* [SVG](https://www.w3schools.com/graphics/svg_intro.asp)
* [XSLT](https://www.w3schools.com/xml/xsl_intro.asp)

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
