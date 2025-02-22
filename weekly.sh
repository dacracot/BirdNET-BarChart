#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
WEEK=`date '+%U'`
# ---------------------------------------------------
# source the configuration file
# it must be edited and copied as ".BirdNET-Barchart" to you home directory
CONFIG_FILE=${HOME}/.BirdNET-Barchart
if [ -f "${CONFIG_FILE}" ]; then
    source ${CONFIG_FILE}
else 
	echo " "
    echo "${CONFIG_FILE} does not exist."
    echo "Copy your edited CONFIGURATION file to ${CONFIG_FILE}"
	echo " "
	exit 1
fi
# ---------------------------------------------------
{
# update the species_list.txt for this location and week of the year
pushd ${ANALYZER_HOME}
source ${ANALYZER_HOME}/venv-birdnet/bin/activate
python3 -m birdnet_analyzer.species --o ${BARCHART_HOME}/work/species_list.txt --lat ${LAT} --lon ${LON} --week ${WEEK}
popd
# remove the frequent false positives
grep -v -f ${BARCHART_HOME}/work/species_blacklist.txt ${BARCHART_HOME}/work/species_list.txt > /tmp/t.txt && cat /tmp/t.txt > ${BARCHART_HOME}/work/species_list.txt
# check how full storage is getting at /
PERCENTSTORAGEUSED=`df -h | grep -oP '\d\d% \/$' | grep -oP '\d\d'`
if [ ${PERCENTSTORAGEUSED} -ge ${PERCENTSTORAGEALLOWED} ]; then
	# compress all logs older than today
	find ${BARCHART_HOME}/logs -mtime +1 -exec gzip {} \;
	# still too much?
	PERCENTSTORAGEUSED=`df -h | grep -oP '\d\d% \/$' | grep -oP '\d\d'`
	if [ ${PERCENTSTORAGEUSED} -ge ${PERCENTSTORAGEALLOWED} ]; then
		# delete all logs older than a week
		find ${BARCHART_HOME}/logs -mtime +7 -name "*.gz" -delete
		# still too much?
		PERCENTSTORAGEUSED=`df -h | grep -oP '\d\d% \/$' | grep -oP '\d\d'`
		# start 90 days out
		COUNTDOWN=90
		while [ ${PERCENTSTORAGEUSED} -ge ${PERCENTSTORAGEALLOWED} ]; do
			# delete all sound samples older than COUNTDOWN days
			find ${BARCHART_HOME}/work -mtime +${COUNTDOWN} -name ".wav.gz" -delete
			# one day closer
			COUNTDOWN=(( --COUNTDOWN ));
			# still too much?
			PERCENTSTORAGEUSED=`df -h | grep -oP '\d\d% \/$' | grep -oP '\d\d'`
		done
	fi
fi
# delete any leftover empty directories
find ${BARCHART_HOME}/work -empty -type d -delete
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-weekly.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-weekly.err
