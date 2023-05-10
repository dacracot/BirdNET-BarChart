#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
YESTERDAY=`date  --date="yesterday" +"%Y-%m-%d"`
# ---------------------------------------------------
{
sqlite3 /home/tweet/birds.db < /home/tweet/html.sql > /var/www/html/tweet/list.html
/home/tweet/plotly.sh 2023 > /var/www/html/tweet/plot.html
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> /home/tweet/${YEAR}-${MONTH}-${DAY}-web.out 2>> /home/tweet/${YEAR}-${MONTH}-${DAY}-web.err
