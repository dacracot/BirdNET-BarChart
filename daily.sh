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
	curl -H "Cache-Control: no-cache, no-store" "wttr.in/38.103516,-121.288475?format=insert+into+celestial+values+('%m','%D','%S','%s','%d',datetime('now','localtime'));" > ${BARCHART_HOME}/celestial.sql
	EXITCODE=$?
	if [[ $EXITCODE -eq 0 ]]
		then
		sqlite3 ${BARCHART_HOME}/birds.db < ${BARCHART_HOME}/celestial.sql
		echo "celestial sucess on attempt ${i}"
		rm ${BARCHART_HOME}/celestial.sql
		break   
	else
		echo "curl: ${EXITCODE}"
		cat ${BARCHART_HOME}/celestial.sql
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
