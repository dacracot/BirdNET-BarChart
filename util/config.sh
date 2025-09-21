#!/bin/bash
# ---------------------------------------------------
SECONDS=0
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
	XSLT_JAR=${HOME}/SaxonJ-HE/
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
read -e -p "Enter the home directory of the barchart software: " -i ${BARCHART_HOME} BARCHART_HOME
echo "Barchart home set to ${BARCHART_HOME}."
# set ANALYZER_HOME... no initial default
echo " "
read -e -p "Enter the home directory of the analyzer software: " -i ${ANALYZER_HOME} ANALYZER_HOME
echo "Analyzer home set to ${ANALYZER_HOME}."
# set XSLT_JAR... no initial default
echo " "
read -e -p "Enter the home of the transformer JAR file, likely saxon-he-*.*.jar: " -i ${XSLT_JAR} XSLT_JAR
echo "Transformer home set to ${XSLT_JAR}."
# set WEB_HOME... /var/www/html/
echo " "
read -e -p "Enter the home directory of the web server: " -i ${WEB_HOME} WEB_HOME
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
read -e -p "Enter your BirdWeather access token [set to blank to disable]: " -i ${BIRDWEATHER_ID} BIRDWEATHER_ID
echo "Token set to ${BIRDWEATHER_ID}."
# set BACKUP_HOME... default to read values
echo " "
read -e -p "Enter the URI for the backup server [set to blank to disable]: " -i ${BACKUP_HOME} BACKUP_HOME
echo "Backup server set to ${BACKUP_HOME}."
# set BACKUP_PASSWORD... no initial default
if [ -z "$BACKUP_HOME" ]; then
    BACKUP_PASSWORD=""
else
	echo " "
	read -e -p "Enter the password for the backup server [set to blank to disable]: " -i ${BACKUP_PASSWORD} BACKUP_PASSWORD
	echo "Password set to ${BACKUP_PASSWORD}."
fi
# set FAILURE_EMAIL... username@somemail.com
echo " "
read -e -p "Enter the email for failure notifications: " -i ${FAILURE_EMAIL} NEW_FAILURE_EMAIL
echo "Email set to ${NEW_FAILURE_EMAIL}."
echo " "
{
MAXTRYS=5
for i in $(seq 1 $MAXTRYS)
do
	curl --max-time 30 -H "Cache-Control: no-cache, no-store" "https://nominatim.openstreetmap.org/reverse?lat=${LAT}&lon=${LON}" > ${BARCHART_HOME}/util/where.xml
	EXITCODE=$?
	if [[ $EXITCODE -eq 0 ]]
		then
		LOCALE=$(java -classpath ${XSLT_JAR} net.sf.saxon.Transform -s:${BARCHART_HOME}/util/where.xml -xsl:${BARCHART_HOME}/util/where.xsl)
		echo "locale success on attempt ${i}"
		break   
	else
		echo "curl: ${EXITCODE}"
		echo "===== locale FAILURE ====="
		sleep 5
	fi
	if [[ ${i} -eq ${MAXTRYS} ]]
		then
		echo "unable to set locale via lat/lon using OpenStreetMap"
		echo "===== locale FAILURE ====="
		LOCALE="Somewhere, Unknown"
	fi
done
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-config.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-config.err
echo "----------"
{
echo "LAT=${LAT}"
echo "LON=${LON}"
echo "LOCALE='${LOCALE}'"
echo "BARCHART_HOME=${BARCHART_HOME}"
echo "ANALYZER_HOME=${ANALYZER_HOME}"
echo "XSLT_JAR=${XSLT_JAR}"
echo "WEB_HOME=${WEB_HOME}"
echo "PERCENT_STORAGE_ALLOWED=${PERCENT_STORAGE_ALLOWED}"
echo "BACKUP_HOME=${BACKUP_HOME}"
echo "BACKUP_PASSWORD=${BACKUP_PASSWORD}"
echo "OWM_TOKEN=${OWM_TOKEN}"
echo "BIRDWEATHER_ID=${BIRDWEATHER_ID}"
echo "FAILURE_EMAIL=${NEW_FAILURE_EMAIL}"
}  > ${HOME}/.BirdNET-BarChart
echo "Source set"
# ---------------------------------------------------
echo " "
if [ -f "${BARCHART_HOME}/birds.db" ]; then
	echo "Do you wish to overwrite your birds database?"
	WARNON='\033[31;5m'
	WARNOFF='\033[0m'
	echo -e "${WARNON}"
	echo -e "--------------------------------------------------------"
	echo -e "YOU WILL LOSE ALL PREVIOUS DATA! THIS CAN NOT BE UNDONE!"
	echo -e "--------------------------------------------------------"
	echo -e "${WARNOFF}"
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
echo "You may now start the analysis/processing."
# ---------------------------------------------------

