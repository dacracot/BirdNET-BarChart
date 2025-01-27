#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
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
# extract the table to XML
sqlite3 ${BARCHART_HOME}/birds.db < ${BARCHART_HOME}/extract.sql > ${BARCHART_HOME}/chart/chart.xml
# transform the xml into html
XSLTransform -s:${BARCHART_HOME}/chart/chart.xml -xsl:${BARCHART_HOME}/chart/chart.xsl > ${BARCHART_HOME}/chart/chart.html
# copy it all to the web server
cp -v -R ${BARCHART_HOME}/chart ${WEB_HOME}
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-extract.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-extract.err
