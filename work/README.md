# work Directory

This is where files are written, read, deleted, and saved from the ongoing process of bird analysis.

---

### Files:

* header.csv
	* Column names in comma separated form for the analyzer results prior to being added to the database.
* species_blacklist.txt
	* List of unwanted bird species to be removed from species_list.txt.
* species_list.txt
	* List of bird species updated weekly for the latitude and longitude using the analyzer.

---

### Subdirectories:

* YEAR
	* MONTH
		* DAY
			* HOUR
				* Sound recordings in WAV format.
					* These may be removed by the weekly process that check whether the disk capacity has exceeded the "percentage of disk usage allowed" set during initial configuration.
				* Analysis results in CSV format.