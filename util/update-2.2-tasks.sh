#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
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
# go to installed root
cd ${BARCHART_HOME}
# check for semaphore
if [ -f "${BARCHART_HOME}/util/update-2.2-tasks.lock" ]; then
	echo "previously run"
else
	touch "${BARCHART_HOME}/util/update-2.2-tasks.lock"
	echo "no action taken"
fi
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-update-2.2-tasks.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-update-2.2-tasks.err
# ---------------------------------------------------
