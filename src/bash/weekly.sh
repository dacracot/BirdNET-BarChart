#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
LASTMONTH=`date -d $(date +%Y)-$(( $(date +%m) - 1 ))-15 +%m`
DAY=`date '+%d'`
WEEK=`date '+%U'`
LAT=37.713
LON=-121.440
# ---------------------------------------------------
{
python3 /home/tweet/BirdNET-Analyzer/species.py --o /home/tweet/samples/species_list.txt --lat ${LAT} --lon ${LON} --week ${WEEK}
grep -v -f /home/tweet/samples/species_blacklist.txt /home/tweet/samples/species_list.txt > /tmp/t.txt && cat /tmp/t.txt > /home/tweet/samples/species_list.txt
find /home/tweet/ -mtime +45 -name "*.gz" -delete
find /home/tweet/samples -mtime +45 -name "*.gz" -delete
find /home/tweet/samples -empty -type d -delete
gzip -v /home/tweet/${YEAR}-${LASTMONTH}-*
df -h
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> /home/tweet/${YEAR}-${MONTH}-${DAY}-weekly.out 2>> /home/tweet/${YEAR}-${MONTH}-${DAY}-weekly.err
