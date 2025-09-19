#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
HOUR=`date '+%H'`
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
WORK_HOUR="${BARCHART_HOME}/work/${YEAR}/${MONTH}/${DAY}/${HOUR}"
# ===================================================
# remove the crontab
export BARCHART_HOME && "${BARCHART_HOME}/util/crontabRemove.sh"
# check if hourly has locked the process
SEMAPHORE="${BARCHART_HOME}/hourly.lock"
MESSAGE="Waiting for hourly completion."
WAITINTERVAL=5
export MESSAGE && export SEMAPHORE && export WAITINTERVAL && "${BARCHART_HOME}/util/blowBubbles.sh"
# stop the last hourly script from sleeping
kill `ps h -eo pid,command | grep "sleep [0-9]*m" | grep -v "grep" | awk '{print $1}'`
echo " " > /dev/tty
# wait for the hourly script to finish
MESSAGE="Wait for the analysis to complete prior to completing.  Usually less than 10 minutes."
export MESSAGE && export SEMAPHORE && export WAITINTERVAL && "${BARCHART_HOME}/util/blowBubbles.sh"
echo " " > /dev/tty
echo "Stopped" > /dev/tty
# ===================================================
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
echo "---------------------------------------------------------------------------------"
}  >> "${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-stop.out" 2>> "${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-stop.err"
