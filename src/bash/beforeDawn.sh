#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
# ---------------------------------------------------
{
mkdir -p /home/tweet/samples/${YEAR}/${MONTH}/${DAY}/
arecord -D sysdefault:CARD=3 --quiet --max-file-time 60 -f S16_LE -r 48000 -t wav --use-strftime /home/tweet/samples/%Y/%m/%d/%Y-%m-%dT%H:%M.wav &
echo "$!" > recording.pid
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> /home/tweet/${YEAR}-${MONTH}-${DAY}-beforeDawn.out 2>> /home/tweet/${YEAR}-${MONTH}-${DAY}-beforeDawn.err