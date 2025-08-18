#!/bin/bash
# ---------------------------------------------------
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
# ---------------------------------------------------
# ---------------------------------------------------
echo "You will be prompted for your Open Weather Map access token and BirdWeather access token." > /dev/tty
echo "The Open Weather Map token is for recording and display current climate conditions.  You may obtain it from https://openweathermap.org. Without it your display will lack climate data." > /dev/tty
echo "The BirdWeather token is for sharing data with the Birdweather maps.  You may obtain it from https://www.birdweather.com. This only necessary if you choose to share with Birdweather." > /dev/tty
read -p "Do you wish to continue (y/n)?" YORN > /dev/tty
case "$YORN" in 
  y|Y ) echo "yes" > /dev/tty;;
  n|N ) echo "no" > /dev/tty; exit;;
  * ) echo "Please answer Y or N" > /dev/tty; exit;;
esac
# ---------------------------------------------------
# does the CONFIG_FILE already exist?
CONFIG_FILE=${HOME}/.BirdNET-BarChart
if [ -f "${CONFIG_FILE}" ]; then
    source ${CONFIG_FILE}
	echo "A configuration file at ${CONFIG_FILE} already exits." > /dev/tty
	echo "Values from this file will be displayed as default choices." > /dev/tty
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
# set BARCHART_HOME
echo " " > /dev/tty
read -e -p "Enter the home of the barchart software: " -i ${BARCHART_HOME} BARCHART_HOME > /dev/tty
if [ -d "$BARCHART_HOME" ]; then
	echo "Barchart home set to ${BARCHART_HOME}." > /dev/tty
else
	echo "${BARCHART_HOME} does not exist." > /dev/tty
	exit
fi
{
# set LAT LON
echo " " > /dev/tty
read -e -p "Enter your latitude: " -i ${LAT} LAT > /dev/tty
echo "Latitude set to ${LAT}." > /dev/tty
echo " " > /dev/tty
read -e -p "Enter your longitude: " -i ${LON} LON > /dev/tty
echo "Latitude set to ${LON}." > /dev/tty
# set ANALYZER_HOME... no initial default
echo " " > /dev/tty
read -e -p "Enter the home of the analyzer software: " -i ${ANALYZER_HOME} ANALYZER_HOME > /dev/tty
echo "Analyzer home set to ${ANALYZER_HOME}." > /dev/tty
# set XSLT_HOME... no initial default
echo " " > /dev/tty
read -e -p "Enter the home of the transformer software, specifically the directory containing the lib and bin subdirectories: " -i ${XSLT_HOME} XSLT_HOME > /dev/tty
echo "Transformer home set to ${XSLT_HOME}." > /dev/tty
# set WEB_HOME... /var/www/html/
echo " " > /dev/tty
read -e -p "Enter the home of the web server: " -i ${WEB_HOME} WEB_HOME > /dev/tty
echo "Web server set to ${WEB_HOME}." > /dev/tty
# set PERCENT_STORAGE_ALLOWED... 60%
echo " " > /dev/tty
read -e -p "Enter the percentage of disk usage allowed: " -i ${PERCENT_STORAGE_ALLOWED} PERCENT_STORAGE_ALLOWED > /dev/tty
echo "Percentage set to ${PERCENT_STORAGE_ALLOWED}." > /dev/tty
# set Open Weather Map Token... no initial default
echo " " > /dev/tty
read -e -p "Enter your Open Weather Map access token: " -i ${OWM_TOKEN} OWM_TOKEN > /dev/tty
echo "Token set to ${OWM_TOKEN}." > /dev/tty
# set BirdWeather Share Token... no initial default
echo " " > /dev/tty
read -e -p "Enter your BirdWeather access token [set to blank to disable]: " -i ${BIRDWEATHER_ID} BIRDWEATHER_ID > /dev/tty
echo "Token set to ${BIRDWEATHER_ID}." > /dev/tty
# set BACKUP_HOME... default to read values
echo " " > /dev/tty
read -e -p "Enter the URI for the backup server [set to blank to disable]: " -i ${BACKUP_HOME} BACKUP_HOME > /dev/tty
echo "Backup server set to ${BACKUP_HOME}." > /dev/tty
# set BACKUP_PASSWORD... no initial default
if [ -z "$BACKUP_HOME" ]; then
    BACKUP_PASSWORD=""
else
	echo " " > /dev/tty
	read -e -p "Enter the password for the backup server [set to blank to disable]: " -i ${BACKUP_PASSWORD} BACKUP_PASSWORD > /dev/tty
	echo "Password set to ${BACKUP_PASSWORD}." > /dev/tty
fi
# set FAILURE_EMAIL... username@somemail.com
echo " " > /dev/tty
read -e -p "Enter the email for failure notifications: " -i ${FAILURE_EMAIL} NEW_FAILURE_EMAIL > /dev/tty
echo "Email set to ${NEW_FAILURE_EMAIL}." > /dev/tty
echo " " > /dev/tty
MAXTRYS=5
for i in $(seq 1 $MAXTRYS)
do
	curl  --max-time 30 -H "Cache-Control: no-cache, no-store" "http://api.openweathermap.org/geo/1.0/reverse?lat=${LAT}&lon=${LON}&limit=1&appid=${OWM_TOKEN}" > ${BARCHART_HOME}/util/where.js
	EXITCODE=$?
	if [[ $EXITCODE -eq 0 ]]
		then
		echo "<where>" > ${BARCHART_HOME}/util/where.xml
		jq -rf ${BARCHART_HOME}/util/json2xml.jq ${BARCHART_HOME}/util/where.js >> ${BARCHART_HOME}/util/where.xml
		echo "</where>" >> ${BARCHART_HOME}/util/where.xml
		LOCALE=$(java -classpath ${XSLT_HOME}/saxon-he-12.8.jar net.sf.saxon.Transform -s:${BARCHART_HOME}/util/where.xml -xsl:${BARCHART_HOME}/util/where.xsl)
		echo "locale success on attempt ${i}"
		break   
	else
		echo "curl: ${EXITCODE}"
		cat ${BARCHART_HOME}/util/where.js
		echo "===== locale FAILURE =====" > /dev/tty
		sleep 5
	fi
	if [[ ${i} -eq ${MAXTRYS} ]]
		then
		echo "unable to set locale via lat/lon" > /dev/tty
		LOCALE="Somewhere, Unknown"
	fi
done
echo "----------" > /dev/tty
{
echo "LAT=${LAT}"
echo "LON=${LON}"
echo "LOCALE='${LOCALE}'"
echo "BARCHART_HOME=${BARCHART_HOME}"
echo "ANALYZER_HOME=${ANALYZER_HOME}"
echo "XSLT_HOME=${XSLT_HOME}"
echo "WEB_HOME=${WEB_HOME}"
echo "PERCENT_STORAGE_ALLOWED=${PERCENT_STORAGE_ALLOWED}"
echo "BACKUP_HOME=${BACKUP_HOME}"
echo "BACKUP_PASSWORD=${BACKUP_PASSWORD}"
echo "OWM_TOKEN=${OWM_TOKEN}"
echo "BIRDWEATHER_ID=${BIRDWEATHER_ID}"
echo "FAILURE_EMAIL=${NEW_FAILURE_EMAIL}"
}  > ${HOME}/.BirdNET-BarChart
echo "Source set" > /dev/tty
# ---------------------------------------------------
echo " " > /dev/tty
if [ -f "${BARCHART_HOME}/birds.db" ]; then
	echo "Do you wish to overwrite your birds database?" > /dev/tty
	WARNON='\033[31;5m'
	WARNOFF='\033[0m'
	echo -e "${WARNON}" > /dev/tty
	echo -e "--------------------------------------------------------" > /dev/tty
	echo -e "YOU WILL LOSE ALL PREVIOUS DATA! THIS CAN NOT BE UNDONE!" > /dev/tty
	echo -e "--------------------------------------------------------" > /dev/tty
	echo -e "${WARNOFF}" > /dev/tty
	select YN in "Yes" "No"; do
		case $YN in
			Yes ) sqlite3 ${BARCHART_HOME}/birds.db < ${BARCHART_HOME}/birds.db.ddl.sql;;
			No ) exit;;
		esac
	done
else
	sqlite3 ${BARCHART_HOME}/birds.db < ${BARCHART_HOME}/birds.db.ddl.sql
fi
echo "Database created" > /dev/tty
# ---------------------------------------------------
echo " "
sed -i "s/${FAILURE_EMAIL}/${NEW_FAILURE_EMAIL}/" ${BARCHART_HOME}/util/backupFailure.txt
sed -i "s/${FAILURE_EMAIL}/${NEW_FAILURE_EMAIL}/" ${BARCHART_HOME}/util/storageFailure.txt
echo "Email text updated" > /dev/tty
# ---------------------------------------------------
# call crontab util
echo "You may now start the analysis/processing." > /dev/tty
# ---------------------------------------------------
echo "---------------------------------------------------------------------------------"
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-config.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-config.err

