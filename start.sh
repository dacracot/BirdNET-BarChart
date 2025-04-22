#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
HOUR=`date '+%H'`
MINUTE=`date '+%M'`
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
{
# ===================================================
# check if we are too close to analysis
if [[ "$MINUTE" =~ ^("58"|"59"|"00")$ ]]; then
    echo "Best not to start on the hour."
    exit 1
else
	# remove hourly script from cron if it is there
	crontab -l 2>/dev/null | grep -v 'hourly' | crontab -
	# add the hourly script to cron
	(crontab -l 2>/dev/null; echo "0 * * * * ${BARCHART_HOME}/hourly.sh") | crontab -
	# run the hourly script
	${BARCHART_HOME}/hourly.sh
fi
# ===================================================
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
echo "---------------------------------------------------------------------------------"
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-start.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-start.err
