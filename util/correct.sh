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

if [[ -z "$1" ]]; then
	echo "Provide the target directory as a parameter."
	exit 3
fi

{
TYPE=csv
WORK_HOUR=$1
AS_OF=`date '+%A, %d %B %Y at %H:00'`
echo "${AS_OF}"
# BirdNET-Analyzer using the species_list.txt created by weekly.sh, creates the CSV file
pushd "${ANALYZER_HOME}"
source "${ANALYZER_HOME}/venv-birdnet/bin/activate"
python3 -m birdnet_analyzer.analyze -o ${WORK_HOUR}/ --rtype ${TYPE} -t 3 --slist "${BARCHART_HOME}/work/species_list.txt" --combine_results ${WORK_HOUR}/
popd
# change file for DB loading
# # change header
cat "${BARCHART_HOME}/work/header.csv" > ${WORK_HOUR}/dataset.csv
cat ${WORK_HOUR}/BirdNET_CombinedTable.csv | grep -v Confidence >> ${WORK_HOUR}/dataset.csv
# # reduce file path to timestamp
sed -i 's@'"${WORK_HOUR}/"'@@' ${WORK_HOUR}/dataset.csv
sed -i 's@.wav@@' ${WORK_HOUR}/dataset.csv
# load the results into the database
sqlite3 "${BARCHART_HOME}/birds.db" << EOF
.import -v --csv --skip 1 ${WORK_HOUR}/dataset.csv heard
EOF
# clean up
find ${WORK_HOUR} -type f -name "*.csv" -not -name "dataset.csv" -delete
gzip ${WORK_HOUR}/*
# ===================================================
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
echo "---------------------------------------------------------------------------------"
}  >> "${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-${MINUTE}-correct.out" 2>> "${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-${MINUTE}-correct.err"
