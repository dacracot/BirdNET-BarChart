#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
YESTERDAY=`date  --date="yesterday" +"%Y-%m-%d"`
# ---------------------------------------------------
{
sqlite3 birds.db < chart.sql > ${YEAR}-${MONTH}-${DAY}-chart.csv
sed -i "s/^/${YESTERDAY}T/" ${YEAR}-${MONTH}-${DAY}-chart.csv
sed -i 's/"//g' ${YEAR}-${MONTH}-${DAY}-chart.csv
sed -i 's/ /,/' ${YEAR}-${MONTH}-${DAY}-chart.csv
sqlite3 birds.db << EOF
.import --csv /home/tweet/${YEAR}-${MONTH}-${DAY}-chart.csv chart
EOF
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> /home/tweet/${YEAR}-${MONTH}-${DAY}-chart.out 2>> /home/tweet/${YEAR}-${MONTH}-${DAY}-chart.err
