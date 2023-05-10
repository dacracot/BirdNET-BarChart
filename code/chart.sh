#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
YESTERDAY=`date  --date="yesterday" +"%Y-%m-%d"`
# ---------------------------------------------------
{
# run the database query and spool a file
sqlite3 /home/tweet/birds.db < chart.sql > ${YEAR}-${MONTH}-${DAY}-chart.csv
# add the date, remove the double quote, and replace space with comma
sed -i "s/^/${YESTERDAY}T/" ${YEAR}-${MONTH}-${DAY}-chart.csv
sed -i 's/"//g' ${YEAR}-${MONTH}-${DAY}-chart.csv
sed -i 's/ /,/' ${YEAR}-${MONTH}-${DAY}-chart.csv
# load the yesterday's chart data into the database
rm /home/tweet/bulb.db
sqlite3 /home/tweet/birds.db << EOF
.import --csv /home/tweet/${YEAR}-${MONTH}-${DAY}-chart.csv heardSumByHour
.clone /home/tweet/bulb.db
EOF
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> /home/tweet/${YEAR}-${MONTH}-${DAY}-chart.out 2>> /home/tweet/${YEAR}-${MONTH}-${DAY}-chart.err
