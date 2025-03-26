#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
CARD=`arecord -l | grep -hom 1 [0-9] | head -1`
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
# create today's destination directory
mkdir -p ${BARCHART_HOME}/work/${YEAR}/${MONTH}/${DAY}/
# record continuously into files of 1 minute each
arecord -D sysdefault:CARD=${CARD} --quiet --max-file-time 60 -f S16_LE -r 48000 -t wav --use-strftime ${BARCHART_HOME}/work/%Y/%m/%d/%Y-%m-%dT%H:%M.wav &
# save the process ID for afterDark.sh
echo "$!" > ${BARCHART_HOME}/recording.pid
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
echo "---------------------------------------------------------------------------------"
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-morning.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-morning.err
