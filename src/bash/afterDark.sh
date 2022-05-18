#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
CONF=0.7
TYPE=csv
# ---------------------------------------------------
{
# kill the audio recording started by beforeDawn.sh
kill `cat /home/tweet/recording.pid`
# loop thru the audio files and analyze each
for f in `ls /home/tweet/samples/${YEAR}/${MONTH}/${DAY}/*.wav`
do
	# BirdNET-Analyzer using the species_list.txt created by weekly.sh, creates the CSV file
    python3 /home/tweet/BirdNET-Analyzer/analyze.py --i ${f} --o ${f%.wav}.${TYPE} --rtype ${TYPE} --min_conf ${CONF} --threads 3 --slist /home/tweet/samples/species_list.txt
    t=$(basename ${f})
    # add the timestamp from the file name to the file content
    sed -i 's/$/,'"${t%.wav}"'/' ${f%.wav}.csv
done
cat /home/tweet/header.csv > /home/tweet/${YEAR}-${MONTH}-${DAY}.csv
# remove the BirdNET-Analyzer headers
cat /home/tweet/samples/${YEAR}/${MONTH}/${DAY}/*.csv | grep -v Confidence >> /home/tweet/tmp.csv
sort -t "," -k3,3 -k5,5nr /home/tweet/tmp.csv > /home/tweet/${YEAR}-${MONTH}-${DAY}.csv
# delete temporary file
rm /home/tweet/tmp*.csv
gzip /home/tweet/samples/${YEAR}/${MONTH}/${DAY}/*
# load the results into the database
sqlite3 /home/tweet/birds.db << EOF
.import --csv --skip 1 /home/tweet/${YEAR}-${MONTH}-${DAY}.csv heardRaw
EOF
# how long did it take
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> /home/tweet/${YEAR}-${MONTH}-${DAY}-afterDark.out 2>> /home/tweet/${YEAR}-${MONTH}-${DAY}-afterDark.err
