#!/bin/bash
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
# ---------------------------------------------------
# ---------------------------------------------------
echo "You will be prompted for your Open Weather Map access token and BirdWeather access token."
echo "The Open Weather Map token is for recording and display current climate conditions.  You may obtain it from https://openweathermap.org. Without it your display will lack climate data."
echo "The BirdWeather token is for sharing data with the Birdweather maps.  You may obtain it from https://www.birdweather.com. This only necessary if you choose to share with Birdweather."
read -p "Do you wish to continue (y/n)?" YORN
case "$YORN" in 
  y|Y ) echo "yes";;
  n|N ) echo "no"; exit;;
  * ) echo "Please answer Y or N"; exit;;
esac
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
	LOCALE="Potter County, South Dakota"
	BARCHART_HOME=${HOME}/BirdNET-BarChart
	ANALYZER_HOME=${HOME}/BirdNET-Analyzer
	XSLT_HOME=${HOME}/SaxonC-HE
	WEB_HOME=/var/www/html
	PERCENT_STORAGE_ALLOWED=60
	BACKUP_HOME=username@192.168.0.123:${HOME}/backups
	BACKUP_PASSWORD=secret
	OWM_TOKEN=secret
	BIRDWEATHER_ID=secret
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
# set XSLT_HOME... no initial default
echo " "
read -e -p "Enter the home of the transformer software, specifically the directory containing the lib and bin subdirectories: " -i ${XSLT_HOME} XSLT_HOME
echo "Transformer home set to ${XSLT_HOME}."
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
# set BirdWeather Share Token... no initial default
echo " "
read -e -p "Enter your BirdWeather access token: " -i ${BIRDWEATHER_ID} BIRDWEATHER_ID
echo "Token set to ${BIRDWEATHER_ID}."
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
echo " "
curl -H "Cache-Control: no-cache, no-store" "http://api.openweathermap.org/geo/1.0/reverse?lat=${LAT}&lon=${LON}&limit=1&appid=${OWM_TOKEN}" > where.js
echo "<where>" > where.xml
jq -rf sky/json2xml.jq where.js >> where.xml
echo "</where>" >> where.xml
LOCALE=`XSLTransform -s:where.xml -xsl:where.xsl`
echo "----------"
{
echo "LAT=${LAT}"
echo "LON=${LON}"
echo "LOCALE='${LOCALE}'"
echo "BARCHART_HOME=${BARCHART_HOME}"
echo "ANALYZER_HOME=${ANALYZER_HOME}"
echo "XSLT_HOME=${XSLT_HOME}"
alias XSLTransform="/usr/lib/ld-linux-aarch64.so.1 --library-path ${XSLT_HOME}/lib ${XSLT_HOME}/bin/Transform"
echo "WEB_HOME=${WEB_HOME}"
echo "PERCENT_STORAGE_ALLOWED=${PERCENT_STORAGE_ALLOWED}"
echo "BACKUP_HOME=${BACKUP_HOME}"
echo "BACKUP_PASSWORD=${BACKUP_PASSWORD}"
echo "OWM_TOKEN=${OWM_TOKEN}"
echo "BIRDWEATHER_ID=${BIRDWEATHER_ID}"
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
