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
function calculateMoonPhase {
	# Input: year, month, day; trim leading zeros
	yy=$YEAR
	mm=${MONTH#0}
	dd=${DAY#0}
	# Adjust month and year
	if [ "$mm" -lt 3 ]; then
	  yy=$((yy - 1))
	  mm=$((mm + 12))
	fi
	mm=$((mm + 1))
	# Calculate components using bc
	c=$(echo "scale=5; 365.25 * $yy" | bc)
	e=$(echo "scale=5; 30.6 * $mm" | bc)
	jd=$(echo "scale=5; $c + $e + $dd - 694039.09" | bc)
	jd=$(echo "scale=5; $jd / 29.5305882" | bc)
	# Integer part (b), and fractional part
	b=$(echo "$jd" | cut -d'.' -f1)
	frac=$(echo "scale=5; $jd - $b" | bc)
	# Multiply fractional part by 8 and round to nearest integer
	b=$(echo "$frac * 8 + 0.5" | bc | cut -d'.' -f1)
	# Normalize if b == 8
	if [ "$b" -ge 8 ]; then
	  b=0
	fi
	# Output results
	case $b in
	  0)
		echo "New Moon"
		;;
	  1)
		echo "Waxing Crescent"
		;;
	  2)
		echo "First Quarter"
		;;
	  3)
		echo "Waxing Gibbous"
		;;
	  4)
		echo "Full Moon"
		;;
	  5)
		echo "Waning Gibbous"
		;;
	  6)
		echo "Last Quarter"
		;;
	  7)
		echo "Waning Crescent"
		;;
	esac
	}
# ---------------------------------------------------
{
# ===================================================
# record celestial data
MAXTRYS=5
for i in $(seq 1 $MAXTRYS)
do
	curl --max-time 30 -H "Cache-Control: no-cache, no-store" "https://aa.usno.navy.mil/api/rstt/oneday?date=${YEAR}-${MONTH}-${DAY}&coords=${LAT},${LON}&tz=-8&dst=true" > ${BARCHART_HOME}/sky/day.js
	EXITCODE=$?
	if [[ $EXITCODE -eq 0 ]]
		then
		echo "<day>" > ${BARCHART_HOME}/sky/day.xml
		jq -rf ${BARCHART_HOME}/util/json2xml.jq ${BARCHART_HOME}/sky/day.js >> ${BARCHART_HOME}/sky/day.xml
		# insert calculated moon phase
		PHASE=$(calculateMoonPhase)
		echo "<phase>${PHASE}</phase>" >> ${BARCHART_HOME}/sky/day.xml
		echo "</day>" >> ${BARCHART_HOME}/sky/day.xml
		java -classpath ${XSLT_JAR} net.sf.saxon.Transform -s:${BARCHART_HOME}/sky/day.xml -xsl:${BARCHART_HOME}/sky/day.xsl > ${BARCHART_HOME}/sky/day.sql
		sqlite3 ${BARCHART_HOME}/birds.db < ${BARCHART_HOME}/sky/day.sql
		echo "celestial success on attempt ${i}"
		break   
	else
		echo "curl: ${EXITCODE}"
		echo "celestial fail on attempt ${i}"
		cat ${BARCHART_HOME}/sky/day.js
		echo "===== celestial FAILURE ====="
		# --------------------------
		# complete failure is ignored
		# subsequent query gets last success
		# --------------------------
		sleep 5
	fi
done
# ===================================================
# save the midnight/noon snapshot to seasonal
find ${BARCHART_HOME}/web/grfx/lunar/ -name "snapshot-*00.png" -type f -exec mv {} ${BARCHART_HOME}/web/grfx/seasonal \;
find ${BARCHART_HOME}/web/grfx/lunar/ -name "snapshot-*12.png" -type f -exec mv {} ${BARCHART_HOME}/web/grfx/seasonal \;
# delete all the snapshots remaining over 30 days old
find ${BARCHART_HOME}/web/grfx/lunar/ -name "snapshot-*.png" -type f -mtime +30 -delete
# roll the current lunar cycle animated gif with imagemagick
convert -layers OptimizePlus -delay 24x100 "${BARCHART_HOME}/web/grfx/lunar/snapshot-*.png" -loop 0 "${BARCHART_HOME}/web/grfx/lunar/dial.gif"
# roll the current seasonal cycle animated gif with imagemagick
convert -layers OptimizePlus -delay 24x100 "${BARCHART_HOME}/web/grfx/seasonal/snapshot-*.png" -loop 0 "${BARCHART_HOME}/web/grfx/seasonal/dial.gif"
# ===================================================
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
echo "---------------------------------------------------------------------------------"
}  >> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-daily.out 2>> ${BARCHART_HOME}/logs/${YEAR}-${MONTH}-${DAY}-${HOUR}-daily.err
