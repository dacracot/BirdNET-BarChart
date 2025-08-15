#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
HOUR=`date '+%H'`
CONFIDENCE=0.0
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
mkdir ${BARCHART_HOME}/share/tmp-BirdWeather
# create file of last hours significant files
sqlite3 ${BARCHART_HOME}/birds.db << EOF
.output ${BARCHART_HOME}/share/tmp-BirdWeather/c75.lst
select distinct minuteOfDay from heard where datetime(minuteOfDay) > datetime('now','localtime','-1 hour') and confidence >= ${CONFIDENCE};
EOF
# read each line
while read TS; do
	# convert from WAV to FLAC
	TARGET="${BARCHART_HOME}/work/${TS:0:4}/${TS:5:2}/${TS:8:2}/${TS:11:2}/${TS}.wav.gz"
	WAV=$(basename "${TARGET}" .gz)
	FLAC=$(basename "${WAV}" .wav)
	# --
	echo "TARGET = ${TARGET}"
	# --
	gunzip -c "${TARGET}" > ${BARCHART_HOME}/share/tmp-BirdWeather/${WAV}
	flac --silent --best ${BARCHART_HOME}/share/tmp-BirdWeather/${WAV}
	rm ${BARCHART_HOME}/share/tmp-BirdWeather/${WAV}
	# POST the file to BirdWeather
	RESPONSE=$(curl --max-time 30 -X POST -H "Content-Type: audio/flac" --data @${BARCHART_HOME}/share/tmp-BirdWeather/${FLAC}.flac -w "|%{http_code}" "https://app.birdweather.com/api/v1/stations/${BIRDWEATHER_ID}/soundscapes?timestamp=${TS}")
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
.output ${BARCHART_HOME}/share/tmp-BirdWeather/c75.js
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
	confidence >= ${CONFIDENCE};
EOF
	# read each line
	while read JS; do
		# POST the JSON of the analyzed file
		# --
		echo "JS = ${JS}"
		# --
		RESPONSE=$(curl --max-time 30 -X POST -H "Content-Type: application/json" --data-raw "`echo ${JS}`" -w "|%{http_code}" "https://app.birdweather.com/api/v1/stations/${BIRDWEATHER_ID}/detections")
		HTTP_CODE=`echo ${RESPONSE} | cut -d "|" -f 2`
		if (($HTTP_CODE < 200 || $HTTP_CODE >= 300)); then
			# handle error
			echo "RESPONSE = ${RESPONSE}"
			echo "HTTP_CODE = ${HTTP_CODE}"
			exit 0
		fi
	done < ${BARCHART_HOME}/share/tmp-BirdWeather/c75.js
done < ${BARCHART_HOME}/share/tmp-BirdWeather/c75.lst
# remove temporary files
rm -r ${BARCHART_HOME}/share/tmp-BirdWeather
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-BirdWeather.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-BirdWeather.err
