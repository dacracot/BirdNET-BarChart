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
# ===================================================
gunzip -v ${BARCHART_HOME}/test/test.wav.gz
pushd ${ANALYZER_HOME}
source ${ANALYZER_HOME}/venv-birdnet/bin/activate
# python3 -m birdnet_analyzer.analyze -o ${BARCHART_HOME}/test/ --rtype csv -t 3 ${BARCHART_HOME}/test/output.csv
python3 -m birdnet_analyzer.analyze -o ${BARCHART_HOME}/test/output --rtype csv -t 3 ${BARCHART_HOME}/test/test.wav 
popd
gzip -v ${BARCHART_HOME}/test/test.wav
diff ${BARCHART_HOME}/test/test.csv ${BARCHART_HOME}/test/output/test.BirdNET.results.csv
RESULT=$?
if [ $RESULT -eq 0 ]
then
	echo "test PASSED" > /dev/tty
elif [ $RESULT -eq 1 ]
then
	{
	echo "=================================="
	echo "=================================="
	echo "test FAILED"
	echo "=================================="
	echo "=================================="
	} > /dev/tty
else
	{
	echo "=================================="
	echo "=================================="
	echo "Something is wrong with the diff command."
	echo "=================================="
	echo "=================================="
	} > /dev/tty
fi
# ===================================================
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
echo "---------------------------------------------------------------------------------"
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-testAnalyzer.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-testAnalyzer.err
