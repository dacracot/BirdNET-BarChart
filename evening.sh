#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
TYPE=csv
# ---------------------------------------------------
# source the configuration file
# it must be edited and copied as ".BirdNET-BarChart" to you home directory
CONFIG_FILE=${HOME}/.BirdNET-BarChart
if [ -f "${CONFIG_FILE}" ]; then
    source ${CONFIG_FILE}
else 
	echo " "
    echo "${CONFIG_FILE} does not exist."
    echo "Copy your edited CONFIGURATION file to ${CONFIG_FILE}"
	echo " "
	exit 1
fi
# ---------------------------------------------------
WORKDAY=${BARCHART_HOME}/work/${YEAR}/${MONTH}/${DAY}
# ---------------------------------------------------
{
# kill the audio recording started by beforeDawn.sh
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
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-evening.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-evening.err
