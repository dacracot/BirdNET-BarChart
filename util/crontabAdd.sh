#!/bin/bash
# ---------------------------------------------------
# remove barchart items first
export BARCHART_HOME && ${BARCHART_HOME}/util/crontabRemove.sh
# use , as sed delimiter
sed "s,@@HOMEDIR@@,${BARCHART_HOME}," "${BARCHART_HOME}/util/crontab.txt" > "${BARCHART_HOME}/TEMPcrontab.txt"
# remove BirdWeather if there is no token
if [ ! -n "$BIRDWEATHER_ID" ]; then
    sed -i '/BirdWeather/d' "${BARCHART_HOME}/TEMPcrontab.txt"
fi
# set the crontab using TEMPcrontab.txt
(crontab -l 2>/dev/null; cat "${BARCHART_HOME}/TEMPcrontab.txt") | crontab -
rm ${BARCHART_HOME}/TEMPcrontab.txt
echo "crontab set"
# ---------------------------------------------------







