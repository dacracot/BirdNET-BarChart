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
# ----------
sqlite3 "${BARCHART_HOME}/birds.db" ".backup '${BARCHART_HOME}/backup/${YEAR}-${MONTH}-${DAY}-${HOSTNAME}-birds.db'"
gzip -v "${BARCHART_HOME}/backup/${YEAR}-${MONTH}-${DAY}-${HOSTNAME}-birds.db"
sshpass -p "${BACKUP_PASSWORD}" scp "${BARCHART_HOME}/backup/${YEAR}-${MONTH}-${DAY}-${HOSTNAME}-birds.db.gz" "${BACKUP_HOME}"
if [ $? -eq 0 ]; then
	rm "${BARCHART_HOME}/backup/${YEAR}-${MONTH}-${DAY}-${HOSTNAME}-birds.db.gz"
else
	ssmtp ${FAILURE_EMAIL} < "${BARCHART_HOME}/util/backupFailure.txt"
fi
# ----------
tar czvf "${BARCHART_HOME}/backup/${YEAR}-${MONTH}-${DAY}-${HOSTNAME}-web.tgz" "${BARCHART_HOME}/web"
sshpass -p "${BACKUP_PASSWORD}" scp "${BARCHART_HOME}/backup/${YEAR}-${MONTH}-${DAY}-${HOSTNAME}-web.tgz" "${BACKUP_HOME}"
if [ $? -eq 0 ]; then
	rm "${BARCHART_HOME}/backup/${YEAR}-${MONTH}-${DAY}-${HOSTNAME}-web.tgz"
else
	ssmtp ${FAILURE_EMAIL} < "${BARCHART_HOME}/util/backupFailure.txt"
fi
# ----------
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> "${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-backup.out" 2>> "${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-backup.err"
