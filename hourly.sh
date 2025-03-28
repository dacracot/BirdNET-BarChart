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
TYPE=csv
WORKDAY=${BARCHART_HOME}/work/${YEAR}/${MONTH}/${DAY}/${HOUR}
ASOF=`date '+%A, %d %B %Y %H:00'`
# ===================================================
# find the audio card
CARD=`arecord -l | grep -hom 1 [0-9] | head -1`
# create today's destination directory
mkdir -p ${BARCHART_HOME}/work/${YEAR}/${MONTH}/${DAY}/${HOUR}/
# record continuously into files of 1 minute each
arecord -D sysdefault:CARD=${CARD} --quiet --max-file-time 60 -f S16_LE -r 48000 -t wav --use-strftime ${BARCHART_HOME}/work/%Y/%m/%d/%H/%Y-%m-%dT%H:%M.wav &
# save the process ID for afterDark.sh
echo "$!" > ${BARCHART_HOME}/recording.pid
# ===================================================
# kill the audio recording started above after an HOUR
sleep 1h
kill `cat ${BARCHART_HOME}/recording.pid`
# directory for audio files and analyze each
# BirdNET-Analyzer using the species_list.txt created by weekly.sh, creates the CSV file
pushd ${ANALYZER_HOME}
source ${ANALYZER_HOME}/venv-birdnet/bin/activate
python3 -m birdnet_analyzer.analyze --i ${WORKDAY}/ --o ${WORKDAY}/ --rtype ${TYPE} --threads 3 --slist ${BARCHART_HOME}/work/species_list.txt --combine_results
popd
# change file for DB loading
# # change header
cat ${BARCHART_HOME}/work/header.csv > ${WORKDAY}/dataset.csv
cat ${WORKDAY}/BirdNET_CombinedTable.csv | grep -v Confidence >> ${WORKDAY}/dataset.csv
# # reduce file path to timestamp
sed -i 's@'"${WORKDAY}/"'@@' ${WORKDAY}/dataset.csv
sed -i 's@.wav@@' ${WORKDAY}/dataset.csv
# load the results into the database
sqlite3 ${BARCHART_HOME}/birds.db << EOF
.import --csv --skip 1 ${WORKDAY}/dataset.csv heard
EOF
# clean up
find ${WORKDAY} -type f -name "*.csv" -not -name "dataset.csv" -delete
gzip ${WORKDAY}/*
# ===================================================
# extract the table to XML
sqlite3 ${BARCHART_HOME}/birds.db < ${BARCHART_HOME}/extract.sql > ${BARCHART_HOME}/chart/chart.xml
# transform the xml into html
XSLTransform -s:${BARCHART_HOME}/chart/chart.xml -xsl:${BARCHART_HOME}/chart/chart.xsl > ${BARCHART_HOME}/chart/chart.html lat=${LAT} lon=${LON} asOf="${ASOF}"
# copy it all to the web server
cp -v -R ${BARCHART_HOME}/chart/ ${WEB_HOME}
cp -v ${BARCHART_HOME}/favicon.ico ${WEB_HOME}
# ===================================================
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
echo "---------------------------------------------------------------------------------"
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-hourly.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-hourly.err
