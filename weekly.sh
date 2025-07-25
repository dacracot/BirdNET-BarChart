#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
WEEK=`date '+%U'`
# ---------------------------------------------------
# source the configuration file
# it must be edited and copied as ".BirdNET-BarChart" to you home directory
CONFIG_FILE=${HOME}/.BirdNET-BarChart
if [ -f "${CONFIG_FILE}" ]; then
    source ${CONFIG_FILE}
else 
	echo " "
    echo "${CONFIG_FILE} does not exist."
    echo "Run the config.sh script to create."
	echo " "
	exit 1
fi
# ---------------------------------------------------
function calculatePercentageUsed {
	ROOTDIR=`echo ${BARCHART_HOME} | cut -d '/' -f 2`
	if mountpoint -q /${ROOTDIR}; then
		echo `df -h | grep -oP "\d{1,2}% \/${ROOTDIR}$" | grep -oP "\d{1,2}"`
	else
		echo "$(df -h | grep -oP '\d{1,2}% \/$' | grep -oP '\d{1,2}')"
	fi
	}
# ---------------------------------------------------
{
# update the species_list.txt for this location and week of the year
pushd ${ANALYZER_HOME}
source ${ANALYZER_HOME}/venv-birdnet/bin/activate
python3 -m birdnet_analyzer.species --lat ${LAT} --lon ${LON} --week ${WEEK} ${BARCHART_HOME}/work/species_list.txt
popd
# remove the frequent false positives
grep -v -f ${BARCHART_HOME}/work/species_blacklist.txt ${BARCHART_HOME}/work/species_list.txt > /tmp/t.txt && cat /tmp/t.txt > ${BARCHART_HOME}/work/species_list.txt
# check how full storage is getting at /
PERCENT_STORAGE_USED=$(calculatePercentageUsed)
echo "${PERCENT_STORAGE_USED} percent used"
if [ ${PERCENT_STORAGE_USED} -ge ${PERCENT_STORAGE_ALLOWED} ]; then
	# compress all logs older than today
	find ${BARCHART_HOME}/logs -not -name "*.md" -mtime +1 -exec gzip -v {} \;
	# still too much?
	PERCENT_STORAGE_USED=$(calculatePercentageUsed)
	echo "${PERCENT_STORAGE_USED} percent used"
	if [ ${PERCENT_STORAGE_USED} -ge ${PERCENT_STORAGE_ALLOWED} ]; then
		# delete all logs older than a week
		find ${BARCHART_HOME}/logs -mtime +7 -name "*.gz" -not -name "*.md" -delete -print
		# still too much?
		PERCENT_STORAGE_USED=$(calculatePercentageUsed)
		echo "${PERCENT_STORAGE_USED} percent used"
		# start 90 days out
		COUNTDOWN=90
		while [ ${PERCENT_STORAGE_USED} -ge ${PERCENT_STORAGE_ALLOWED} ]; do
			# delete all sound samples older than COUNTDOWN days
			find ${BARCHART_HOME}/work -mtime +${COUNTDOWN} -name "*.wav.gz" -delete -print
			# one day closer
			((COUNTDOWN--))
			if [ ${COUNTDOWN} -ge 0 ]; then
				echo "${COUNTDOWN} days out"
			else
				ssmtp -vvv dacracot@gmail.com < ${BARCHART_HOME}/util/storageFailure.txt
				exit 1
			fi
			# still too much?
			PERCENT_STORAGE_USED=$(calculatePercentageUsed)
			echo "${PERCENT_STORAGE_USED} percent used"
		done
	fi
fi
# delete any leftover empty directories
find ${BARCHART_HOME}/work -empty -type d -delete
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-weekly.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-weekly.err
