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
NEWTAG=`git tag | tail -n 1`
# ---------------------------------------------------
if [ "${NEWTAG}" = "2.1" ]; then
    echo "migrating to 2.1"
    # migration tasks
else
	echo "migrating to ${NEWTAG} is unsupported"
	echo "migration was set for 2.1"
fi
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
echo "---------------------------------------------------------------------------------"
# ---------------------------------------------------
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-upgrade.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-upgrade.err
