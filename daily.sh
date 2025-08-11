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
# ===================================================
# record celestial data
MAXTRYS=5
for i in $(seq 1 $MAXTRYS)
do
	curl -H "Cache-Control: no-cache, no-store" "https://aa.usno.navy.mil/api/rstt/oneday?date=${YEAR}-${MONTH}-${DAY}&coords=${LAT},${LON}&tz=-8&dst=true" > ${BARCHART_HOME}/sky/day.js
	EXITCODE=$?
	if [[ $EXITCODE -eq 0 ]]
		then
		echo "<day>" > ${BARCHART_HOME}/sky/day.xml
		jq -rf ${BARCHART_HOME}/util/json2xml.jq ${BARCHART_HOME}/sky/day.js >> ${BARCHART_HOME}/sky/day.xml
		echo "</day>" >> ${BARCHART_HOME}/sky/day.xml
		java -classpath ${XSLT_HOME}/saxon-he-12.8.jar net.sf.saxon.Transform -s:${BARCHART_HOME}/sky/day.xml -xsl:${BARCHART_HOME}/sky/day.xsl > ${BARCHART_HOME}/sky/day.sql
		sqlite3 ${BARCHART_HOME}/birds.db < ${BARCHART_HOME}/sky/day.sql
		echo "celestial sucess on attempt ${i}"
		break   
	else
		echo "curl: ${EXITCODE}"
		cat ${BARCHART_HOME}/sky/day.js
		echo "===== celestial FAILURE ====="
		sleep 5
	fi
done
# ===================================================
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
echo "---------------------------------------------------------------------------------"
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-daily.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-daily.err
