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
# start xml
sqlite3 ${BARCHART_HOME}/birds.db  ".read ${BARCHART_HOME}/chart/chartHead.sql" > ${BARCHART_HOME}/chart/chart.xml
# echo "confidence 0.25"
# echo "last 24 hours"
sqlite3 ${BARCHART_HOME}/birds.db ".param set :confidence 0.25" ".param set :timeRange '24'" ".param set :timeUnit 'hour'" ".read ${BARCHART_HOME}/chart/chart.sql" >> ${BARCHART_HOME}/chart/chart.xml
# echo "confidence 0.50"
# echo "last 24 hours"
sqlite3 ${BARCHART_HOME}/birds.db ".param set :confidence 0.50" ".param set :timeRange '24'" ".param set :timeUnit 'hour'" ".read ${BARCHART_HOME}/chart/chart.sql" >> ${BARCHART_HOME}/chart/chart.xml
# echo "confidence 0.75"
# echo "last 24 hours"
sqlite3 ${BARCHART_HOME}/birds.db ".param set :confidence 0.75" ".param set :timeRange '24'" ".param set :timeUnit 'hour'" ".read ${BARCHART_HOME}/chart/chart.sql" >> ${BARCHART_HOME}/chart/chart.xml
# close xml and query chart
sqlite3 ${BARCHART_HOME}/birds.db  ".read ${BARCHART_HOME}/chart/chartTail.sql" >> ${BARCHART_HOME}/chart/chart.xml
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-chart.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-chart.err
