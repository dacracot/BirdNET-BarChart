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
# check for semaphore
if [ -f "${BARCHART_HOME}/util/updates/update-@@TAG@@-tasks.lock" ]; then
	echo "previously run"
else
	touch "${BARCHART_HOME}/util/updates/update-@@TAG@@-tasks.lock"
	# ===================================================================================
	# ===================================================================================
	#
	# Update tasks coded here.
	echo "no action necessary"
	#
	# ===================================================================================
	# ===================================================================================
fi
# cascade the update to previous tasks
${BARCHART_HOME}/util/updates/update-@@PREV@@-tasks.sh
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-update-@@TAG@@-tasks.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-update-@@TAG@@-tasks.err
# ---------------------------------------------------
