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
    echo "Starting this close to the hour can" > /dev/tty
    echo "interfere with semaphore protection." > /dev/tty
    echo "Wait a few minutes and try again." > /dev/tty
    exit 1
else
	# reset the crontab
	export BARCHART_HOME && export BIRDWEATHER_ID && "${BARCHART_HOME}/util/crontabAdd.sh"
    nohup "${BARCHART_HOME}/hourly.sh" &
fi
echo "Started" > /dev/tty
# ===================================================
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
echo "---------------------------------------------------------------------------------"
}  >> "${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-start.out" 2>> "${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-start.err"
