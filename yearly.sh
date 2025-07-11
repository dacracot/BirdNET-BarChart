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
	curl -H "Cache-Control: no-cache, no-store" "https://aa.usno.navy.mil/api/seasons?${YEAR}=2025&tz=-8&dst=true" > ${BARCHART_HOME}/sky/season.js
	EXITCODE=$?
	if [[ $EXITCODE -eq 0 ]]
		then
		echo "<season>" > ${BARCHART_HOME}/sky/season.xml
		jq -rf ${BARCHART_HOME}/sky/json2xml.jq ${BARCHART_HOME}/sky/season.js >> ${BARCHART_HOME}/sky/season.xml
		echo "</season>" >> ${BARCHART_HOME}/sky/season.xml
		${XSLTransform} -s:${BARCHART_HOME}/sky/season.xml -xsl:${BARCHART_HOME}/sky/season.xsl > ${BARCHART_HOME}/sky/season.sql
		sqlite3 ${BARCHART_HOME}/birds.db < ${BARCHART_HOME}/sky/season.sql
		echo "celestial sucess on attempt ${i}"
		break   
	else
		echo "curl: ${EXITCODE}"
		cat ${BARCHART_HOME}/sky/season.js
		echo "===== celestial FAILURE ====="
		sleep 5
	fi
done
# ===================================================
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
echo "---------------------------------------------------------------------------------"
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-yearly.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-yearly.err
