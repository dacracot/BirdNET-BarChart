#!/bin/bash
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
# ---------------------------------------------------
# ---------------------------------------------------
# does the CONFIG_FILE already exist?
CONFIG_FILE=${HOME}/.BirdNET-BarChart
if [ -f "${CONFIG_FILE}" ]; then
    source ${CONFIG_FILE}
	echo "A configuration file at ${CONFIG_FILE} already exits."
	echo "Values from this file will be displayed as default choices."
else 
	LAT=45.0
	LON=-100.0
	BARCHART_HOME=${HOME}/BirdNET-BarChart
	ANALYZER_HOME=${HOME}/BirdNET-Analyzer
	WEB_HOME=/var/www/html
	PERCENT_STORAGE_ALLOWED=60
	BACKUP_HOME=username@192.168.0.123:${HOME}/backups
	BACKUP_PASSWORD=secret
	FAILURE_EMAIL=username@somemail.com
fi
# ---------------------------------------------------
# set LAT LON
echo " "
read -e -p "Enter your latitude: " -i ${LAT} LAT
echo "Latitude set to ${LAT}."
echo " "
read -e -p "Enter your longitude: " -i ${LON} LON
echo "Latitude set to ${LON}."
# set BARCHART_HOME
echo " "
read -e -p "Enter the home of the barchart software: " -i ${BARCHART_HOME} BARCHART_HOME
echo "Barchart home set to ${BARCHART_HOME}."
# set ANALYZER_HOME... no initial default
echo " "
read -e -p "Enter the home of the analyzer software: " -i ${ANALYZER_HOME} ANALYZER_HOME
echo "Analyzer home set to ${ANALYZER_HOME}."
# set WEB_HOME... /var/www/html/
echo " "
read -e -p "Enter the home of the web server: " -i ${WEB_HOME} WEB_HOME
echo "Web server set to ${WEB_HOME}."
# set PERCENT_STORAGE_ALLOWED... 60%
echo " "
read -e -p "Enter the percentage of disk usage allowed: " -i ${PERCENT_STORAGE_ALLOWED} PERCENT_STORAGE_ALLOWED
echo "Percentage set to ${PERCENT_STORAGE_ALLOWED}."
# set Open Weather Map Token... no initial default
echo " "
read -e -p "Enter your Open Weather Map access token: " -i ${OWM_TOKEN} OWM_TOKEN
echo "Token set to ${OWM_TOKEN}."
# set BACKUP_HOME... default to read values
echo " "
read -e -p "Enter the URI for the backup server: " -i ${BACKUP_HOME} BACKUP_HOME
echo "Backup server set to ${BACKUP_HOME}."
# set BACKUP_PASSWORD... no initial default
echo " "
read -e -p "Enter the password for the backup server: " -i ${BACKUP_PASSWORD} BACKUP_PASSWORD
echo "Password set to ${BACKUP_PASSWORD}."
# set FAILURE_EMAIL... no initial default
echo " "
read -e -p "Enter the email for failure notifications: " -i ${FAILURE_EMAIL} NEW_FAILURE_EMAIL
echo "Email set to ${NEW_FAILURE_EMAIL}."
{
echo "LAT=${LAT}"
echo "LON=${LON}"
echo "BARCHART_HOME=${BARCHART_HOME}"
echo "ANALYZER_HOME=${ANALYZER_HOME}"
echo "WEB_HOME=${WEB_HOME}"
echo "PERCENT_STORAGE_ALLOWED=${PERCENT_STORAGE_ALLOWED}"
echo "BACKUP_HOME=${BACKUP_HOME}"
echo "BACKUP_PASSWORD=${BACKUP_PASSWORD}"
echo "OWM_TOKEN=${OWM_TOKEN}"
echo "FAILURE_EMAIL=${FAILURE_EMAIL}"
}  > ${HOME}/.BirdNET-BarChart
echo "Source set"
# ---------------------------------------------------
echo " "
if [ -f "${BARCHART_HOME}/birds.db" ]; then
	echo "Do you wish to overwrite your birds database?"
	echo "THIS CAN NOT BE UNDONE."
	select YN in "Yes" "No"; do
		case $YN in
			Yes ) sqlite3 ${BARCHART_HOME}/birds.db < ${BARCHART_HOME}/birds.db.ddl.sql;;
			No ) exit;;
		esac
	done
else
	sqlite3 ${BARCHART_HOME}/birds.db < ${BARCHART_HOME}/birds.db.ddl.sql
fi
echo "Database created"
# ---------------------------------------------------
echo " "
sed -i "s/${FAILURE_EMAIL}/${NEW_FAILURE_EMAIL}/" ${BARCHART_HOME}/util/backupFailure.txt
sed -i "s/${FAILURE_EMAIL}/${NEW_FAILURE_EMAIL}/" ${BARCHART_HOME}/util/storageFailure.txt
echo "Email text updated"
# ---------------------------------------------------
# call crontab util
export BARCHART_HOME && ${BARCHART_HOME}/util/crontabAdd.sh
# ---------------------------------------------------
