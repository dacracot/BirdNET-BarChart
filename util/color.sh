#!/bin/bash
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
function assignColor {
sqlite3 ${BARCHART_HOME}/birds.db << EOF
insert into
	color
select
	name,
	'$1'
from
	candidate
order by
	random()
limit
	1;
delete from
	candidate
where
	name in (select name from color);
EOF
}
# ---------------------------------------------------
echo " "
TMP=`sqlite3 ${BARCHART_HOME}/birds.db << EOF
.mode csv
select
	commonName,
	(count(commonName)*sum(confidence))
from
	heard
where
	commonName not in (select commonName from color)
group by
	commonName
order by
	2 desc
limit
	1;
EOF`
TOP=`echo $TMP | cut -d',' -f1 | tr -d '"'`
echo "$TOP is the top candidate by frequency and confidence."
echo "Assign a color to $TOP?"
# deal with quotes
BIRD=$(echo "$TOP" | sed "s/'/''/g")
select YN in "Yes" "No"; do
	case $YN in
		Yes ) assignColor "$BIRD"; exit;;
		No ) exit;;
	esac
done
# ---------------------------------------------------
