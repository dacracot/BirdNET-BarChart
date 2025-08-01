#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
HOUR=`date '+%H'`
MINUTE=`date '+%M'`
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
TYPE=csv
WORK_HOUR=${BARCHART_HOME}/work/${YEAR}/${MONTH}/${DAY}/${HOUR}
AS_OF=`date '+%A, %d %B %Y at %H:00'`
echo "${AS_OF}"
pushd ${BARCHART_HOME}
TAG=`git tag | tail -n 1`
WHEN=`git show --date=format:'%A, %d %B %Y at %H:%M' --stat ${TAG} | sed -n '3p' | cut -d' ' -f4,5,6,7,8,9`
VERSION=`git show --date=format:'%A, %d %B %Y at %H:%M' --stat ${TAG} | sed -n '5,7p' | awk 'NF'`
popd
COMMIT="${VERSION} ${WHEN}"
echo "${COMMIT}"
# ===================================================
# find the audio card
CARD=`arecord -l | grep -hom 1 [0-9] | head -1`
# create todays destination directory
mkdir -p ${BARCHART_HOME}/work/${YEAR}/${MONTH}/${DAY}/${HOUR}/
# record continuously into files of 1 minute each
arecord -D sysdefault:CARD=${CARD} --quiet --max-file-time 60 -f S16_LE -r 48000 -t wav --use-strftime ${BARCHART_HOME}/work/%Y/%m/%d/%H/%Y-%m-%dT%H:%M.wav &
# save the process ID for recordings
echo "$!" > ${WORK_HOUR}/recording.pid
# ===================================================
# kill the audio recording started above on the hour
HOWLONG=$((60-`date '+%M'`))
sleep ${HOWLONG}m
# stop recording
kill `cat ${WORK_HOUR}/recording.pid`
rm ${WORK_HOUR}/recording.pid
# record weather data
MAXTRYS=5
for i in $(seq 1 $MAXTRYS)
do
	curl -H "Cache-Control: no-cache, no-store" "https://api.openweathermap.org/data/2.5/weather?lat=${LAT}&lon=${LON}&mode=xml&units=imperial&appid=${OWM_TOKEN}" > ${BARCHART_HOME}/sky/weather.xml
	EXITCODE=$?
	if [[ $EXITCODE -eq 0 ]]
		then
		java -classpath ${XSLT_HOME}/saxon-he-12.8.jar net.sf.saxon.Transform -s:${BARCHART_HOME}/sky/weather.xml -xsl:${BARCHART_HOME}/sky/weather.xsl > ${BARCHART_HOME}/sky/weather.sql
		sqlite3 ${BARCHART_HOME}/birds.db < ${BARCHART_HOME}/sky/weather.sql
		echo "weather sucess on attempt ${i}"
		break   
	else
		echo "curl: ${EXITCODE}"
		cat ${BARCHART_HOME}/sky/weather.xml
		echo "===== weather FAILURE ====="
		sleep 5
	fi
done
# directory for audio files and analyze each
# BirdNET-Analyzer using the species_list.txt created by weekly.sh, creates the CSV file
pushd ${ANALYZER_HOME}
source ${ANALYZER_HOME}/venv-birdnet/bin/activate
python3 -m birdnet_analyzer.analyze -o ${WORK_HOUR}/ --rtype ${TYPE} -t 3 --slist ${BARCHART_HOME}/work/species_list.txt --combine_results ${WORK_HOUR}/
popd
# change file for DB loading
# # change header
cat ${BARCHART_HOME}/work/header.csv > ${WORK_HOUR}/dataset.csv
cat ${WORK_HOUR}/BirdNET_CombinedTable.csv | grep -v Confidence >> ${WORK_HOUR}/dataset.csv
# # reduce file path to timestamp
sed -i 's@'"${WORK_HOUR}/"'@@' ${WORK_HOUR}/dataset.csv
sed -i 's@.wav@@' ${WORK_HOUR}/dataset.csv
# load the results into the database
sqlite3 ${BARCHART_HOME}/birds.db << EOF
.import -v --csv --skip 1 ${WORK_HOUR}/dataset.csv heard
EOF
# clean up
find ${WORK_HOUR} -type f -name "*.csv" -not -name "dataset.csv" -delete
gzip ${WORK_HOUR}/*
# ===================================================
# extract the table to XML
sqlite3 ${BARCHART_HOME}/birds.db < ${BARCHART_HOME}/web/birding.sql > ${BARCHART_HOME}/web/birding.xml
# transform the xml into html
java -classpath ${XSLT_HOME}/saxon-he-12.8.jar net.sf.saxon.Transform -s:${BARCHART_HOME}/web/birding.xml -xsl:${BARCHART_HOME}/web/birding.xsl > ${BARCHART_HOME}/web/birding.html locale="${LOCALE}" asOf="${AS_OF}" commit="${COMMIT}"
# copy it all to the web server
mkdir -p ${WEB_HOME}/BirdNET-BarChart
cp -v -R ${BARCHART_HOME}/web/grfx ${WEB_HOME}/BirdNET-BarChart
cp -v ${BARCHART_HOME}/web/birding.* ${WEB_HOME}/BirdNET-BarChart
cp -v ${BARCHART_HOME}/web/help.* ${WEB_HOME}/BirdNET-BarChart
# ===================================================
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
echo "---------------------------------------------------------------------------------"
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-hourly.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-hourly.err
