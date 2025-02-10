#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
BIRDWEATHER_ID="secret"
# ---------------------------------------------------
# source the configuration file
# it must be edited and copied as ".BirdNET-Barchart" to you home directory
CONFIG_FILE=${HOME}/.BirdNET-Barchart
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
{
# create file of yesterdays significant files
sqlite3 ${BARCHART_HOME}/birds.db << EOF
.output ${BARCHART_HOME}/share/temp75.lst
select distinct minuteOfDay from heard where substr(minuteOfDay,1,10) = date('now','-1 day') and confidence >= 0.75;
EOF
# read each line
while read TS; do
	# POST the file to BirdWeather
	RESPONSE=$(curl -X POST -H "Content-Type: application/octet-stream" -H "Content-Encoding: application/gzip" --data @${BARCHART_HOME}/work/${TS:0:4}/${TS:5:2}/${TS:8:2}/${TS}.wav.gz -w "|%{http_code}" "https://app.birdweather.com/api/v1/stations/${BIRDWEATHER_ID}/soundscapes?timestamp=${TS}")
	HTTP_CODE=`echo ${RESPONSE} | cut -d "|" -f 2`
	if (($HTTP_CODE < 200 || $HTTP_CODE >= 300)); then
		# handle error
		echo "RESPONSE = ${RESPONSE}"
		echo "HTTP_CODE = ${HTTP_CODE}"
		exit 0
	else
		# get the returned soundscapeId from JSON response
		SID=`echo ${RESPONSE} | cut -d "|" -f 1 | jq '.soundscape.id'`
		# --
		echo "SID = ${SID}"
		echo "TS  = ${TS}"
		# --
	fi
	# create file of analysis
sqlite3 ${BARCHART_HOME}/birds.db << EOF
.param set :lat ${LAT}
.param set :lon ${LON}
.param set :sid ${SID}
.param set :ts ${TS}
.output ${BARCHART_HOME}/share/temp75.js
select
	json_object(
		'timestamp', :ts,
		'lat', :lat,
		'lon', :lon,
		'soundscapeId', :sid,
		'soundscapeStartTime', startSecond,
		'soundscapeEndTime', endSecond,
		'commonName', commonName,
		'scientificName', scientificName,
		'confidence', confidence
		)
from
	heard
where
	minuteOfDay = :ts
		and
	confidence >= 0.75;
EOF
	# read each line
	while read JS; do
		# POST the JSON of the analyzed file
		# --
		echo "JS = ${JS}"
		# --
		RESPONSE=$(curl -X POST -H "Content-Type: application/json" --data-raw "`echo ${JS}`" -w "|%{http_code}" "https://app.birdweather.com/api/v1/stations/${BIRDWEATHER_ID}/detections")
		HTTP_CODE=`echo ${RESPONSE} | cut -d "|" -f 2`
		if (($HTTP_CODE < 200 || $HTTP_CODE >= 300)); then
			# handle error
			echo "RESPONSE = ${RESPONSE}"
			echo "HTTP_CODE = ${HTTP_CODE}"
			exit 0
		fi
	done < ${BARCHART_HOME}/share/temp75.js
done < ${BARCHART_HOME}/share/temp75.lst
# remove temp files
rm ${BARCHART_HOME}/share/temp75.*
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-BirdWeather.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-BirdWeather.err
