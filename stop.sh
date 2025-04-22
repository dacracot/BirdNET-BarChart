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
WORK_HOUR=${BARCHART_HOME}/work/${YEAR}/${MONTH}/${DAY}/${HOUR}
# ===================================================
# check if we are too close to analysis
if [[ "$MINUTE" =~ ^("58"|"59"|"00"|"01"|"02"|"03"|"04"|"05"|"06"|"07"|"08"|"09"|"10")$ ]]; then
    echo "Best not to stop this close to the hour."
    exit 1
else
	# remove hourly script from cron
	crontab -l 2>/dev/null | grep -v 'hourly' | crontab -
	# stop the last hourly script from sleeping
	kill `ps h -eo pid,command | grep "sleep 1h" | grep -v "grep" | awk '{print $1}'`
	echo "Wait for the analysis to complete prior to restarting."
fi
# ===================================================
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
echo "---------------------------------------------------------------------------------"
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-stop.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-stop.err
