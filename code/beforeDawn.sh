#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
# ---------------------------------------------------
{
# create today's destination directory
mkdir -p /home/tweet/samples/${YEAR}/${MONTH}/${DAY}/
# record continuously into files of 1 minute each
arecord -D sysdefault:CARD=3 --quiet --max-file-time 60 -f S16_LE -r 48000 -t wav --use-strftime /home/tweet/samples/%Y/%m/%d/%Y-%m-%dT%H:%M.wav &
# save the process ID for afterDark.sh
echo "$!" > recording.pid
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> /home/tweet/${YEAR}-${MONTH}-${DAY}-beforeDawn.out 2>> /home/tweet/${YEAR}-${MONTH}-${DAY}-beforeDawn.err
