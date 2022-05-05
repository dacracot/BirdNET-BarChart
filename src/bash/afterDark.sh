#!/bin/bash
SECONDS=0
# ---------------------------------------------------
YEAR=`date '+%Y'`
MONTH=`date '+%m'`
DAY=`date '+%d'`
CONF=0.6
TYPE=csv
# ---------------------------------------------------
{
kill `cat /home/tweet/recording.pid`
for f in `ls /home/tweet/samples/${YEAR}/${MONTH}/${DAY}/*.wav`
do
    python3 /home/tweet/BirdNET-Analyzer/analyze.py --i ${f} --o ${f%.wav}.${TYPE} --rtype ${TYPE} --min_conf ${CONF} --threads 3 --slist /home/tweet/samples/species_list.txt
    t=$(basename ${f})
    sed -i 's/$/,'"${t%.wav}"'/' ${f%.wav}.csv
done
cat /home/tweet/header.csv > /home/tweet/${YEAR}-${MONTH}-${DAY}.csv
cat /home/tweet/samples/${YEAR}/${MONTH}/${DAY}/*.csv | grep -v Confidence >> /home/tweet/t1.csv
sort -t "," -k3,3 -k5,5nr /home/tweet/t1.csv > /home/tweet/t2.csv
cut -d ',' -f 4,5- t2.csv >> /home/tweet/${YEAR}-${MONTH}-${DAY}.csv
rm /home/tweet/t*.csv
gzip /home/tweet/samples/${YEAR}/${MONTH}/${DAY}/*
sqlite3 birds.db << EOF
.import --csv --skip 1 /home/tweet/${YEAR}-${MONTH}-${DAY}.csv found
EOF
DURATION=$SECONDS
echo "$(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds elapsed."
}  >> /home/tweet/${YEAR}-${MONTH}-${DAY}-afterDark.out 2>> /home/tweet/${YEAR}-${MONTH}-${DAY}-afterDark.err
