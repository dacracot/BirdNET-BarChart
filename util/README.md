# util Directory

This is where utility scripts and text files reside.

---

### Files:

* color.sh
	* Set a consistent color for the most popular bird not yet assigned a color.
* backupFailure.txt
	* Email contents for a backup failure message.
* correct.sh
	* Run the analyzer against a directory of WAV files and load results into the database, but nothing more.
	* First parameter to the script is the directory to be analyzed.
* crontabAdd.sh
	* Add yearly, weekly, daily, hourly, and backup scripts to the crontab.
* crontabRemove.sh
	* Remove yearly, weekly, daily, hourly, and backup scripts to the crontab.
* crontab.txt
	* Default crontab times and scripts.
* storageFailure.txt
	* Email contents for a storage trimming failure message.
