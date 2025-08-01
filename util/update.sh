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
# check if current branch is main
BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$BRANCH" = "main" ]; then
	# pull latest
	git pull
	# scripting to adjust volatile components
	${BARCHART_HOME}/util/update-2.2-tasks.sh
else
	echo "branch is not main"
	echo "no action taken"
fi
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-update.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-update.err
# ---------------------------------------------------
